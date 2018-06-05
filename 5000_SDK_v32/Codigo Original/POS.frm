
[Forma]
Clave=POS
Icono=39
Modulos=(Todos)

ListaCarpetas=(Lista)
CarpetaPrincipal=Codigo
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=-8
PosicionInicialArriba=-8
PosicionInicialAlturaCliente=811
PosicionInicialAncho=1552
PosicionSec1=488
VentanaTipoMarco=Ninguno
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Maximizado
PosicionCol2=638
PosicionSec2=565
PosicionCol3=766
PosicionCol1=638
Nombre=<T>POS<T>
VentanaExclusiva=S
VentanaExclusivaOpcion=0
Plantillas=S
PermiteCopiarDoc=S
VentanaConIcono=S
BotonesPanelColor=Negro
VentanaColor=$00804000
VentanaAjustarZonas=S
VentanaCarpetasSinBordes=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
DeshabilitarAyuda=S
Menus=S
ExpresionesAlMostrar=Asigna(Pos.MultiMoneda,SQL(<T>SELECT MultiMoneda FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>Asigna(Pos.AgenteDetalle,sql(<T>SELECT POSAgenteDetalle FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>Asigna(Pos.WebService,sql(<T>SELECT WebService FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>Asigna(Info.Empresa, Empresa)<BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Ticket, Nulo)<BR>Asigna(Ver.Saldo, Nulo)<BR>Asigna(Ver.Totales, Nulo)<BR>Asigna(Ver.Total, Nulo)               <BR>Asigna(Ver.Aviso, Nulo)  .<BR>Asigna(Ver.Expresion2, Nulo)<BR>Asigna(Ver.Memo, <T>Bienvenido<T>)<BR>Asigna(Info.POSLogo,Nulo)<BR>Asigna(Info.POSPublicidad,SQL(<T>SELECT Publicidad FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR><BR>Asigna(Info.IDTexto, SQL(<T>spPOSAbrir :tEmpresa, :tUsuario<T>, Empresa,Usuario))<BR>EjecutarSQL(<T>spPOSInicializar  :tEmpresa, :nSucursal, :tUsuario, :nEstacion, :tID, :tDirectorioTrabajo<T>,Empresa, Sucursal, Usuario, EstacionTrabajo, Info.IDTexto, DirectorioAplicacion)<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR><BR>Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8]) <BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen, Temp.Reg[11])<BR>Asigna(Info.CtaCaja,Temp.Reg[18])<BR>Asigna(Info.Grupo,Temp.Reg[19])<BR>Asigna(Temp.Num, 0)<BR>Forma.AsignarAnuncios(Ver.Imagen,Info.POSPublicidad ,5 )<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR>Forma.ActualizarVista(<T>Ticket<T>)<BR>Asigna(Info.Numero, 1)
ExpresionesAlCerrar=Asigna(Info.Numero, 1)   <BR>Asigna(Info.Torreta,SQL(<T>SELECT TieneTorreta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>Si<BR>  Info.Torreta<BR>Entonces<BR>   Torreta.Cerrar <BR>Fin
ExpresionesAlActivar=Asigna(Info.Torreta,SQL(<T>SELECT TieneTorreta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>Si<BR>  Info.Torreta<BR>Entonces<BR>  Asigna(Info.TorretaPuerto,SQL(<T>SELECT PuertoTorreta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>   Torreta.Abrir(Info.TorretaPuerto)<BR>Asigna(Info.TorretaMensaje1,<T>*** BIENVENIDO ***<T>)<BR>Asigna(Info.TorretaPosicion1,<T>Centrado<T>)<BR>Asigna(Info.TorretaMensaje2,NULO))<BR>Asigna(Info.TorretaPosicion2,<T>Derecha<T>)<BR><BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>Fin<BR>//Asigna(Temp.Logico,SQL(<T>SELECT POSDutyFree FROM POSCfg WHERE Empresa=:tEmpresa<T>, Empresa)) Si Temp.Logico Entonces Forma(<T>DatosVueloDF<T>) Fin<BR><BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR><BR>si (SQL(<T>SELECT PanelAMostrar FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<><T>Imágenes<T><BR>entonces<BR>Forma.IrCarpeta(<T>btnCategoria<T>)<BR>sino<BR>Forma.IrCarpeta(<T>Imagen<T>)<BR>fin<BR><BR>BarraIrPagina(<T>Saldo<T>,1)<BR><BR>Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  nulo, Info.IDTexto))<BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Asigna(Temp.POSMonederoL,SQL(<T>SELECT Monedero FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))
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
Descripcion1=350
0=99
1=375
Cliente=117
RFC=107
Estado=236
Delegacion=126
Colonia=216
CodigoPostal=71
Ruta=109
Grupo=100
Codigo=124
2=-2
3=-2
SerieLote=153
Unidad=122
Mov=124
MovID=64
FechaEmision=74
Referencia=96
Concepto=94
AnticipoSaldo=96
Moneda=61
AnticipoAplicar=91
4=-2
Serie=189
Importe=85
EstatusNombre=89
Tipo=88
Saldo=79
Modulo=38
Unidad_1=73
Estatus=94
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
Fuente={Tahoma, 12, Blanco, [Negritas]}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=$00804000
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Ver.Ticket
AlinearTodaCarpeta=S

ConFuenteEspecial=S



BarraBotones=S
ListaAccionesBB=(Lista)
BarraBotonesFuente={MS Sans Serif, 10, Negro, []}
BarraBotonesColor=$00C08000
BarraBotonesPosicion=Abajo
BarraBotonesImagenPosicion=Abajo
SizeBarraBotones=100
SizeBotonBarraBotones=100
BarraBtnFuente={Tahoma, 12, Blanco, []}
BarraBtnFondo=$00804000
BarraBtnPosicion=Abajo
BarraBtnSize=100
BarraBtnSeparacion=2
BarraBtnBisel=0
CarpetaVisible=S
BarraBtnPaginas=1
BarraBtnSinBisel=S
CondicionEdicion=Info.Numero
[Codigo]
Estilo=Ficha
Clave=Codigo
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=(Variables)
Fuente={Segoe UI, 12, Azul, []}
FichaEspacioEntreLineas=1
FichaEspacioNombres=0
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=$00FFFFFE
CampoColorLetras=$00C08000
CampoColorFondo=Blanco
ListaEnCaptura=Info.Codigo
CampoAccionAlEnter=Enter
CarpetaVisible=S

ConFuenteEspecial=S
BarraBotones=S
BarraBtnFuente={Tahoma, 10, Blanco, []}
BarraBtnFondo=Blanco
BarraBtnPosicion=Derecha
BarraBtnSize=75
BarraBtnSeparacion=2
BarraBtnSinBisel=S
ListaAccionesBB=(Lista)
BarraBtnBisel=0
FichaEspacioNombresAuto=S
AlinearTodaCarpeta=S
BarraBtnPaginas=1
[Codigo.Info.Codigo]
Carpeta=Codigo
Clave=Info.Codigo
Editar=S
LineaNueva=N
ValidaNombre=N
3D=N
AccionAlEnter=Enter
Tamano=20












AccionAlEnterBloquearAvance=S
OcultaNombre=N
Pegado=N
ConScroll=N
SinRecapitular=N
ColorFuente=$00C08000
Color=Negro
ColorFondo=Blanco
[Totales.]
Carpeta=Totales
ColorFondo=Negro
ColorFuente=Lima











































































[Aviso]
Estilo=Ficha
Clave=Aviso
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=(Variables)
Fuente={Segoe UI, 16, Verde, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=$00FEF5DA
FichaAlineacionDerecha=S
CampoColorLetras=$004646FF
CampoColorFondo=$00FDFBCE
ListaEnCaptura=Ver.Aviso
CarpetaVisible=S
AlinearTodaCarpeta=S

ConFuenteEspecial=S
[Aviso.Ver.Aviso]
Carpeta=Aviso
Clave=Ver.Aviso
Editar=S
LineaNueva=S
3D=N
Tamano=60
ColorFondo=$00FDFBCE
ColorFuente=$004646FF


















































[Alm.ListaEnCaptura]
(Inicio)=Alm.Almacen
Alm.Almacen=Alm.Nombre
Alm.Nombre=(Fin)




[Lista.ListaEnCaptura]
(Inicio)=Alm.Almacen
Alm.Almacen=Alm.Nombre
Alm.Nombre=(Fin)













































[Acciones.Enter]
Nombre=Enter
Boton=-1
NombreDesplegar=&Enter
GuardarAntes=S
EnBarraAcciones=S
TipoAccion=Expresion
Activo=S
Visible=S


















































































































































































































































































































































































































































































































































































































































































Multiple=S
ListaAccionesMultiples=(Lista)
ConCondicion=S


RefrescarDespues=S
EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT Abierto FROM POSEstatusCaja WHERE Caja=:tcaja<T>,Info.CtaCaja))<BR>Si(( Info.Cerrado)= 0, Error(<T>Caja Cerrada, Por Favor de Verifique.........<T>))
[Campos.Columnas]
Articulo=114
SubCuenta=81
Precio=86
DescuentoLinea=96
Cantidad=56













































FormaPago=171
Importe=114
Referencia=177
Opcion=124
ArtSubCuenta=237
Componente=213
Almacen=64
Total=91
Impuestos=64
PrecioConImp=103
CantidadM=99
Unidad=69
DescuentoAd=82
Agente=74
[FormaExtraValor.Columnas]
VerCampo=173
VerValor=153

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
NombreDesplegar=<BR>Afectar Movimiento
TipoAccion=Expresion
Activo=S
Visible=S























































































































































































ConCondicion=S
EjecucionConError=S
Multiple=S
ListaAccionesMultiples=(Lista)
EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>NO(Info.Cerrado)
EjecucionMensaje=<T>Caja Bloqueada<T>
[Imagen]
Estilo=Ficha
Clave=Imagen
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Ver.Imagen
AlinearTodaCarpeta=S

AutoRefrescar=S
TiempoRefrescar=00:10
CondicionVisible=(SQL(<T>SELECT PanelAMostrar FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))=<T>Imágenes<T>
[Imagen.Ver.Imagen]
Carpeta=Imagen
Clave=Ver.Imagen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20x10
ColorFondo=Blanco




























































[Saldo]
Estilo=Ficha
Clave=Saldo
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=C1
Vista=(Variables)
ConFuenteEspecial=S
Fuente={Segoe UI, 14, Blanco, [Negritas]}
FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=$00804000
FichaAlineacionDerecha=S
CampoColorLetras=Blanco
CampoColorFondo=$00804000
CarpetaVisible=S


ListaEnCaptura=(Lista)
PermiteEditar=S

BarraBotones=S
BarraBtnFuente={Tahoma, 10, Blanco, []}
BarraBtnFondo=$00804000
BarraBtnPosicion=Abajo
BarraBtnSize=80
BarraBtnSeparacion=2
BarraBtnSinBisel=S
ListaAccionesBB=(Lista)
BarraBtnBisel=0
FichaEspacioNombresAuto=S
BarraBtnPaginas=6
[Acciones.BuscarArticulo]
Nombre=BuscarArticulo
Boton=0
NombreDesplegar=<BR>&Buscar Artículo
TipoAccion=Expresion
Activo=S























































































































































ConCondicion=S
EjecucionConError=S
UsaTeclaRapida=S
Visible=S
Expresion=FormaModal(<T>POSArtLista<T>)<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR><BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>/*Asigna(Ver.Saldo, TextoEnLista(Temp.Reg[10]))*/<BR><BR>/*Cuando hay una expresion de regreso la ejecuta*/<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>Si<BR>  ConDatos(Ver.Expresion)<BR>Entonces<BR>  Reexpresa( Ver.Expresion )<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>Fin<BR>Asigna(Ver.Expresion, Nulo)<BR>Asigna(Info.Codigo, Nulo)<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>NO(Info.Cerrado)
EjecucionMensaje=<T>Caja Bloqueada<T>
[Hoja.Columnas]
Mov=124
MovID=124
FechaEmision=94
Importe=64



















































































Cliente=64


















0=-2
1=94
2=71
3=293
[UsoServicio.Columnas]
Servicio=293
Fecha=94
Porcentaje=38
Evaluacion=87
Observaciones=189


















































































































































































































































































































































































[Acciones.POSMonedero]
Nombre=POSMonedero
Boton=0
NombreDesplegar=<BR>&Información Monedero
TipoAccion=Formas
ClaveAccion=POSMonedero
Activo=S
Visible=S


















































































































































































































































































































































































































































































Multiple=S
ListaAccionesMultiples=(Lista)
ConCondicion=S
EjecucionConError=S
Menu=Menú Principal &.
EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>NO(Info.Cerrado)
EjecucionMensaje=<T>Caja Bloqueada<T>

[Acciones.Encabezado.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=FormaModal(<T>POSL<T>)<BR><BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Info.Usuario,Usuario)<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Info.Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>Si ConDatos(Info.Observaciones)<BR>  Entonces Error( Info.Observaciones )<BR>Sino <T><T>                                                                                                             <BR>  Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>                                  <BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR><BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>EjecutarSQL(<T>spPOSUsuarioDesautoriza :tID<T>,Info.IDTexto)<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
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


Expresion=Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR><BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR><BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>/*Asigna(Ver.Saldo, TextoEnLista(Temp.Reg[10]))*/<BR><BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[POSArtJuegoComponente.Columnas]
Componente=205
ArtSubCuenta=473












































































































































































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









[Acciones.CancelarOfertas]
Nombre=CancelarOfertas
Boton=0
NombreDesplegar=Cancelar Ofertas Puntos
TipoAccion=Expresion
Activo=S
Visible=S







ConCondicion=S




EjecucionConError=S











Expresion=Asigna(Info.POSMonedero, SQL(<T>SELECT Monedero FROM POSL WHERE ID = :tID<T>, Info.IDTexto))<BR>Asigna(Info.MonedaBase,SQL(<T>SELECT Moneda FROM POSValeSerie  WHERE Serie = :tMonedero<T>, Info.POSMonedero))<BR>FormaModal(<T>POSOfertaTempCancelacion<T>)<BR>Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>,EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR>Si ConDatos(Info.Observaciones)<BR>  Entonces Error( Info.Observaciones )<BR>  Sino <T><T><BR>Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>Asigna(Info.POSMonedero, SQL(<T>SELECT Monedero FROM POSL WHERE ID = :tID<T>, Info.IDTexto))<BR>(ConDatos(Info.POSMonedero))y(NO(Info.Cerrado))
EjecucionMensaje=Si(Info.Cerrado,<T>Caja Bloqueada<T>,<T>No Hay Ningun Monedero Asociado<T>)
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



































































4=-2
5=-2
[POSCxcAnticipoTemp.Columnas]
FechaEmision=94
Referencia=173
Concepto=210
AnticipoSaldo=71
Moneda=64
AnticipoAplicar=77































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































0=75
1=117
2=99
3=116
4=99
5=78
6=85
7=95
[Acciones.Afectar.Afectar]
Nombre=Afectar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Numero,SQL(<T>spPOSInsertarCobroCondicionTemp :tID, :tEmpresa, :nEstacion, :nSucursal, :tUsuario<T>, Info.IDTexto, Empresa, EstacionTrabajo, Sucursal, Usuario)) Si (Info.Numero = 1)  Entonces     FormaModal(<T>POSCobroCondicionTemp<T>)   Fin<BR>Asigna(Info.MovClaveAfecta, SQL(<T>SELECT mt.Clave FROM POSL p INNER JOIN MovTipo mt ON p.Mov = mt.Mov AND mt.Modulo = :tPOS WHERE p.ID = :tID<T>, <T>POS<T>, Info.IDTexto))<BR>Asigna(Info.Mensaje,Nulo)<BR>Asigna(Info.IDTextoAnterior, Info.IDTexto)<BR>Asigna(Info.POSMonedero,Nulo)<BR>EjecutarSQL(<T>spPOSOfertaPuntosImporte :tEmpresa,:nEstacion,:tID<T>,Empresa, EstacionTrabajo, Info.IDTexto)<BR>Asigna(Info.POSRedondeo, SQL(<T>EXEC spPOSVentaInsertaRedondeo :tID, :tTipo<T>, Info.IDTexto, <T>SUGERIR<T>))<BR>Asigna(Info.POSRedondeo2,0.0)<BR>EjecutarSQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>ELIMINAR COBRO<T>,Nulo)<BR>Asigna(Info.Acumulativa,SQL(<T>SELECT RedondeoVenta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>Asigna(Info.Acumulativa,SQL(<T>SELECT dbo.fnPOSTieneServicioLDI(:tID, :lBit)<T>,Info.IDTexto, Info.Acumulativa))<BR>Si(Info.MovClaveAfecta=<T>POS.FA<T>,Asigna(Info.Acumulativa,0))<BR>Si(Info.MovClaveAfecta=<T>POS.CXCC<T>,Asigna(Info.Acumulativa,0))<BR>Si (Info.Importe >= 0)y(Info.MovClaveAfecta en(<T>POS.F<T>,<T>POS.N<T>,<T>POS.FA<T>,<T>POS.CXCC<T>))<BR>  Entonces<BR>    SI  Info.Acumulativa<BR>      Entonces<BR>        Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>       Asigna(Info.Saldo, Temp.Reg[9])<BR>       Asigna(Info.Importe, Temp.Reg[9])<BR>        FormaModal(<T>POSRedondeo<T>)<BR>      Sino<BR>        FormaModal(<T>POSCobro<T>)<BR>    Fin<BR>Sino<BR>  Si Info.MovClaveAfecta En( <T>POS.N<T>,<T>POS.CXCD<T>)<BR>    Entonces FormaModal(<T>POSCobroNegativo<T>)<BR>  Sino<BR>    Asigna(Info.Codigo, SQL(<T>SELECT Codigo FROM CB WHERE Accion = :tAccion<T>, <T>CONCLUIR MOVIMIENTO<T>))<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, Info.Importe, Info.FormaPagoCambio, Info.Cambio, 0, Nulo, Nulo, Info.POSMonedero))<BR>    Asigna(Info.Codigo, Nulo)<BR>  Fin<BR>Fin<BR>Asigna(Info.POSImporteOferta,Nulo)<BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*Si ConDatos(Info.Observaciones)<BR>  Entonces Informacion(Info.Observaciones )<BR>Sino <T><T><BR>  Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR><BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>Asigna(Ver.Expresion2, TextoEnLista(Temp.Reg[20]))<BR>Si ConDatos(Ver.Expresion)<BR>Entonces Reexpresa( Ver.Expresion )<BR>Fin<BR>SI(ConDatos(Ver.Expresion2),Reexpresa( Ver.Expresion2 ))<BR><BR>Asigna(Ver.Expresion, Nulo)<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero,:nImporteRef<T>, EstacionTrabajo, NULO, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto,Nulo, Info.FormaPagoCambio, Info.Cambio, 1, Nulo, Nulo, Info.POSMonedero,NULO))<BR><BR>Si(Info.MovClaveAfecta EN(<T>POS.N<T>,<T>POS.F<T>, <T>POS.CXCC<T>),Si(ConDatos(Info.Mensaje),Asigna(Ver.Aviso,Ver.Aviso+NuevaLinea+Info.Mensaje)))<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>/*Cuando hay una expresion de regreso la ejecuta*/<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>Asigna(Ver.Expresion2, TextoEnLista(Temp.Reg[20]))<BR>Si ConDatos(Ver.Expresion)<BR>Entonces Reexpresa( Ver.Expresion )<BR>Fin<BR>Asigna(Ver.Expresion, Nulo)<BR>Asigna(Ver.Expresion2, Nulo)<BR>Asigna(Info.POSRedondeo, nulo)<BR>Asigna(Temp.Logico,SQL(<T>SELECT POSDutyFree FROM POSCfg WHERE Empresa=:tEmpresa<T>, Empresa)) Si Temp.Logico Entonces Forma(<T>DatosVueloDF<T>) Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
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
[POSCobroCondicionTemp.Columnas]
Articulo=124
Descripcion1=184
Precio=64
PrecioTotal=69
FormaPago=304

Cantidad=64
[Acciones.POSCobroCondicionTemp]
Nombre=POSCobroCondicionTemp
Boton=0
NombreDesplegar=Condicione Cobro
GuardarAntes=S
TipoAccion=Expresion
Activo=S
Visible=S

















































































































































































































































Expresion=EjecutarSQL(<T>spPOSInsertarCobroCondicionTemp :tID, :tEmpresa, :nEstacion, :nSucursal, :tUsuario<T>, Info.IDTexto, Empresa, EstacionTrabajo, Sucursal, Usuario)<BR>FormaModal(<T>POSCobroCondicionTemp<T>)<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Lista2.Columnas]
Mov=124
MovID=64
FechaEmision=75
Referencia=99
Concepto=84
AnticipoSaldo=71
Moneda=64
AnticipoAplicar=99


























































































































































































































































[Acciones.EliminarMov]
Nombre=EliminarMov
Boton=0
NombreDesplegar=Eliminar Mov
GuardarAntes=S
TipoAccion=Expresion
Activo=S








































































Visible=S
Expresion=EjecutarSQL(<T>spPOSEliminarMov :tID<T>,Info.IDTexto)<BR>Asigna(Info.Codigo,SQL(<T>SELECT Codigo FROM CB WHERE Accion = :tAccion<T>,<T>ELIMINAR MOVIMIENTO<T>))<BR>Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>,EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Asigna(Info.Codigo,Nulo)<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[PorCobrar.Columnas]
0=109
1=40
2=-2
3=69
4=103

[CobrosPosfechados.Columnas]
0=135
1=82
2=-2
3=-2

[VentaPendiente.Columnas]
0=130
1=81
2=-2
3=132
















[Acciones.Regresar]
Nombre=Regresar
Boton=0
NombreDesplegar=Regresar
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




















































































































































































Menu=Menú Principal &.

Expresion=Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Nulo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR><BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])                  <BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>/*Asigna(Ver.Saldo, TextoEnLista(Temp.Reg[10]))*/<BR><BR>SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR><BR><BR><BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR><BR>Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>Asigna(Info.CtaCaja,Temp.Reg[18])<BR>Asigna(Info.Grupo,Temp.Reg[19])<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.Afectar.ValidarDetalle]
Nombre=ValidarDetalle
Boton=0
TipoAccion=Expresion
Activo=S
ConCondicion=S
EjecucionConError=S
Visible=S





EjecucionCondicion=Asigna(Info.SeCompra,SQL(<T>SELECT dbo.fnPOSValidaPOSLVenta(:tID)<T>,Info.IDTexto))<BR>Info.SeCompra
EjecucionMensaje=<T>NO HAY NADA QUE AFECTAR<T>
[POSVentaPedidoDTemp2.Columnas]
Cantidad=64
Articulo=124
SubCuenta=304
Unidad=101
Precio=64
Importe=64
CantidadAplicar=119















Codigo=184












































































































[Acciones.Eliminar]
Nombre=Eliminar
Boton=0
NombreDesplegar=&Eliminar Captura
TipoAccion=Expresion
Activo=S










































































Multiple=S
ListaAccionesMultiples=(Lista)
UsaTeclaRapida=S
TeclaRapida=F6
Visible=S
ConCondicion=S
EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR>Forma(<T>POSMovAutorizarSup<T>)<BR>SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1




[Acciones.Cantidad]
Nombre=Cantidad
Boton=0
NombreDesplegar=<T>Modificar Cantidad<T>
TipoAccion=Expresion
Activo=S
ConCondicion=S
EjecucionConError=S




Visible=S
Expresion=Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioAccion WHERE Usuario = :tUsuario AND Accion = :tAccion<T>, Usuario, <T>MODIFICAR CANTIDAD<T>) = 1<BR>Entonces<BR>  Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>MODIFICAR CANTIDAD<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.TextoTemp02, nulo)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>NO(Info.Cerrado)
EjecucionMensaje=<T>Caja Bloqueada<T>
[Acciones.CancelarPartida]
Nombre=CancelarPartida
Boton=0
NombreDesplegar=<T>Cancelar Partida<T>
TipoAccion=Expresion
Activo=S




Visible=S
Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.Bloquear]
Nombre=Bloquear
Boton=0
NombreDesplegar=Bloquear / Desbloquear Caja
RefrescarDespues=S
TipoAccion=Expresion
Activo=S




Visible=S
Expresion=Asigna(Temp.Caja,SQL(<T>SELECT DefCtaDinero FROM Usuario WHERE Usuario = :tUsuario<T>, Usuario))<BR>Asigna(Temp.TextoTemp01,SQL(<T>SELECT HOST FROM POSiSync<T>))<BR>Asigna(Temp.POSCajaLogico, SQL(<T>SELECT Bloqueado FROM POSEstatusCaja WHERE Abierto = :nAbierto AND Caja = :Caja AND Usuario = :tUsuario AND HOST = :tHOST<T>, 1, Temp.Caja, Usuario, Temp.TextoTemp01))<BR><BR>FormaModal(<T>POSMovAutorizar<T>)<BR>Si<BR>  (Temp.POSCajaLogico = 0) y (Info.Usuario = SQL(<T>SELECT Usuario FROM POSEstatusCaja WHERE Abierto = :nAbierto AND Caja = :Caja AND Usuario = :tUsuario<T>, 1, Temp.Caja, Usuario))<BR>Entonces<BR>  Asigna(Temp.TextoTemp01,SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>BLOQUEAR CAJA<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp01, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))  <BR>Sino<BR>  Asigna(Temp.TextoTemp01,SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>DESBLOQUEAR CAJA<T>))<BR>Fin<BR><BR><BR>Si<BR>  Info.Usuario = SQL(<T>SELECT Usuario FROM POSEstatusCaja WHERE Abierto = :nAbierto AND Caja = :Caja AND Usuario = :tUsuario<T>, 1, Temp.Caja, Usuario)<BR>Entonces<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp01, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>Sino<BR>  Informacion(<T>Cajero Incorrecto, para desbloquear la caja es necesario que se firme el Cajero: <T>+ Mayusculas(Usuario))<BR>Fin<BR><BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Asigna(Temp.TextoTemp01, nulo)<BR>Asigna(Temp.Caja, nulo)<BR>Asigna(Temp.TextoTemp01, nulo)<BR>Asigna(Temp.POSCajaLogico, 0)<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.AccionesValidas.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Dialogo(<T>PosMenuEspecial<T>)<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.AccionesValidas.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.AccionesValidas.Minimizar]
Nombre=Minimizar
Boton=0
TipoAccion=Ventana
ClaveAccion=Minimizar
Activo=S
Visible=S


[Acciones.Salir]
Nombre=Salir
Boton=0
NombreDesplegar=Salir POS
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S









[Acciones.Enter.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S



Expresion=Asigna(Temp.Logico,SQL(<T>SELECT dbo.fnPOSValidarBloquearCaja(:tCodigo)<T>,Info.Codigo))<BR>Asigna(Pos.POSPesar,SQL(<T>SELECT ActivaBascula FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>Si(Temp.Logico,FormaModal(<T>POSMovAutorizar<T>))<BR><BR>Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR>Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))                                        <BR><BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR><BR>Si Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T> y Pos.POSPesar<BR>Entonces<BR>FormaModal(<T>POSPesar<T>)<BR>EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>Fin<BR><BR><BR>SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR><BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR><BR>Asigna(Info.TorretaMensaje1,Temp.Reg[14])<BR>Asigna(Info.TorretaMensaje2,Temp.Reg[15])<BR>Asigna(Info.TorretaPosicion1,Temp.Reg[16])<BR>Asigna(Info.TorretaPosicion2,Temp.Reg[17])<BR>Asigna(Info.CtaCaja,Temp.Reg[18])<BR>Asigna(Info.Grupo,Temp.Reg[19])<BR><BR><BR>Si<BR>  ConDatos(Info.TorretaMensaje1) y(Info.Torreta)<BR>Entonces<BR>    Torreta.Escribir( Info.TorretaMensaje1,Info.TorretaMensaje2,Info.TorretaPosicion1,Info.TorretaPosicion2)<BR>Fin<BR><BR><BR><BR>Asigna(Info.Cliente,Nulo)<BR>/*Cuando hay una expresion de regreso la ejecuta*/<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>Si ConDatos(Ver.Expresion)<BR>Entonces<BR>  Reexpresa( Ver.Expresion )<BR>  Asigna(Ver.Expresion, Nulo)<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta, :tCliente<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo, Info.Cliente))<BR>  Asigna(Info.Cliente,Nulo)<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>Fin<BR><BR>Si ConDatos(Ver.Expresion)<BR>Entonces<BR>  Reexpresa( Ver.Expresion )<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta, :tCliente<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo, Info.Cliente))<BR>  Asigna(Info.Cliente,Nulo)<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>Fin<BR>Asigna(Ver.Expresion, Nulo)<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.AccionesValidas.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Forma
Actualizar Forma=Minimizar
Minimizar=(Fin)


















[Acciones.POSUsuario2]
Nombre=POSUsuario2
Boton=0
Activo=S
Visible=S










Menu=Menú Edición
NombreDesplegar=&Usuario Autorizar
TipoAccion=Formas
ClaveAccion=POSMovAutorizar






ConCondicion=S






EjecucionConError=S


















































































EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>NO(Info.Cerrado)
EjecucionMensaje=<T>Caja Bloqueada<T>
[Acciones.Eliminar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S











Expresion=Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioAccion WHERE Usuario = :tUsuario AND Accion = :tAccion<T>, Info.Usuario, <T>ELIMINAR MOVIMIENTO<T>) = 1<BR>Entonces<BR>  Asigna(Info.Codigo, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>ELIMINAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.Eliminar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Eliminar.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S




[Saldo.Pos.TextoDescuento]
Carpeta=Saldo
Clave=Pos.TextoDescuento
Editar=N
LineaNueva=N
ValidaNombre=S
3D=N
Tamano=12

ColorFuente=Rojo
Efectos=[Negritas]
ColorFondo=$00804000
Pegado=S
[Saldo.Pos.TextoImpuestos]
Carpeta=Saldo
Clave=Pos.TextoImpuestos
Editar=N
ValidaNombre=S
3D=N
Tamano=12

ColorFuente=Blanco
Efectos=[Negritas]
ColorFondo=$00804000
Pegado=S
[Saldo.Pos.TextoSubtotal]
Carpeta=Saldo
Clave=Pos.TextoSubtotal
Editar=N
ValidaNombre=S
3D=N
Tamano=12
ColorFondo=$00804000

ColorFuente=Blanco
Efectos=[Negritas]





















Pegado=S
[POSCBFormaPago.Columnas]
Codigo=274































































































































































































































































































0=-2
[Total.Ver.Total]
Carpeta=Total
Clave=Ver.Total
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=$00A00000
Efectos=[Negritas]
































































































































































































































[Acciones.MenuEspecial.ListaAccionesMultiples]
(Inicio)=Cerrar
Cerrar=Expresion
Expresion=(Fin)









































[Acciones.Accion1.expresion]
Nombre=expresion
Boton=0
TipoAccion=Expresion
Expresion=Si<BR>  SQL(<T>spPOSEstadoCaja :tID, :tUsuario<T>, Info.IDTexto, Usuario) = 0<BR>Entonces<BR>Asigna(Info.Mov, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CAMBIAR MOVIMIENTO<T>))<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>Asigna(Info.Mov, SQL(<T>SELECT AperturaCaja FROM POSMovMenuSupervision WHERE Empresa = :tEmpresa<T>, Info.Empresa))<BR>Asigna(Info.Mov, SQL(<T>SELECT m.Orden FROM POSUsuarioMov p JOIN MovTipo m ON p.Mov = m.Mov WHERE m.Modulo=:tm  AND p.Usuario =:tu AND p.Mov =:tMov<T>, <T>POS<T>, Usuario , Info.Mov))<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>Asigna(Info.CtaDinero, SQL(<T>SELECT NULLIF(DefCtaDineroTrans, :tnulo) FROM Usuario WHERE Usuario =:tu<T>, <T> <T>,Usuario ))<BR>Si<BR>  Info.CtaDinero = nulo              <BR>Entonces<BR>  Asigna(Temp.Numerico5,1)<BR>  Forma(<T>ListaCtaAperturaCaja<T>)<BR>Sino<BR><BR><BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.CtaDinero, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>Asigna(Temp.TextoTemp01, SQL(<T>SELECT DefFormaPago FROM Usuario WHERE Usuario = :tUsuario<T>, Usuario ))<BR>Asigna(Temp.TextoTemp01, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND FormaPago = :tFormaPago<T>, <T>Forma Pago<T>, Temp.TextoTemp01))<BR><BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp01, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>Si ConDatos(Info.Observaciones)<BR>  Entonces Informacion( Info.Observaciones )<BR>Sino <T><T><BR>  Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR><BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR><BR>Forma(<T>PosMenuEspecialSupervicion<T>)<BR>FIN<BR><BR>Sino<BR>Informacion(<T>La caja ya esta abierta... Verifique..<T> )<BR>Fin
Activo=S
Visible=S







[Acciones.Accion1.ListaAccionesMultiples]
(Inicio)=expresion1
expresion1=Actualizar Vista
Actualizar Vista=Actualizar Forma
Actualizar Forma=(Fin)


































































[Acciones.Devolucion.expresion]
Nombre=expresion
Boton=0
TipoAccion=expresion
Expresion=Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioAccion WHERE Usuario = :tUsuario AND Accion = :tAccion<T>, Usuario, <T>DEVOLUCION TOTAL<T>) = 1<BR>Entonces<BR>  Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>DEVOLUCION TOTAL<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.TextoTemp02, nulo)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
Activo=S
Visible=S




































































[Acciones.Afectar.ValidaDevoluciones]
Nombre=ValidaDevoluciones
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Si<BR>  Temp.Num = 1<BR>Entonces<BR>  FormaModal(<T>POSLVentaDev<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR>Fin<BR><BR>Asigna(Temp.Num, 0)
[Acciones.Eliminar.ValidaDevolucion]
Nombre=ValidaDevolucion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S



Expresion=Asigna(Temp.Num, 0)

[Acciones.CancelarPartida.expresion]
Nombre=expresion
Boton=0
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S








Expresion=Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioAccion WHERE Usuario = :tUsuario AND Accion = :tAccion<T>, Usuario, <T>CANCELAR PARTIDA<T>) = 1<BR>Entonces<BR>  Si      <BR>  Confirmacion( <T>¿Desea Eliminar Todo el Renglon?<T>, BotonSi, BotonNo ) = BotonSi    <BR>    Entonces      EjecutarSQL(<T>spPOSCancelarPartida :tID, :nEliminaRenglon<T>, Info.IDTexto, 1)     <BR>    Sino      EjecutarSQL(<T>spPOSCancelarPartida :tID, :nEliminaRenglon<T>, Info.IDTexto, 0)    <BR>  Fin    <BR>  Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CANCELAR PARTIDA<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.TextoTemp02, nulo)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR>Forma(<T>POSMovAutorizarSup<T>)<BR>SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1
[Acciones.CancelarPartida.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.CancelarPartida.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S



[Acciones.CobroCredito.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

















Expresion=Asigna(Info.Mov, <T>Cobro Credito<T>)<BR><BR>Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioMov WHERE Mov = :tMov AND Usuario = :tUsuario<T>, Info.Mov, Usuario) = 1<BR>Entonces<BR><BR>  Asigna(Info.Mov, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CAMBIAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Mov, <T>Cobro Credito<T>)<BR>  Asigna(Info.Mov, SQL(<T>SELECT m.Orden FROM POSUsuarioMov p JOIN MovTipo m ON p.Mov = m.Mov WHERE m.Modulo=:tm  AND p.Usuario =:tu AND p.Mov =:tMov<T>, <T>POS<T>, Usuario , Info.Mov))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR><BR>  Forma(<T>POSCteLista<T>)<BR>  Forma(<T>POSCxcPendiente<T>)  <BR>  //Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.TextoTemp02, nulo)<BR> Fin<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso al Movimiento<T>)<BR>Fin
[Acciones.CobroCredito.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=CxcPendiente
CxcPendiente=(Fin)



























































[NegociaMoratorios.Columnas]
Aplica=148
AplicaID=141
Importe=141
InteresesMoratorios=149









































































Sugerido=64






ImporteTotal=69
Saldo=86
SaldoTotal=64
SaldoInteresesMoratorios=127




























































DiasMoratorios=78


































































































































































































[Accesorios.Columnas]
Accesorio=94
Descripcion1=186

[Refacciones.Columnas]
Refaccion=80
Descripcion1=152
Cantidad=49

[Servicios.Columnas]
Servicio=81
Descripcion1=153
Cantidad=46

[Consumibles.Columnas]
Consumible=80
Descripcion1=153
Cantidad=48

[Sustitutos.Columnas]
Sustituto=94
Descripcion1=187

[ArtCosto.Columnas]
0=57
1=114
2=-2

[SubCostos.Columnas]
0=83
1=160
2=-2
3=-2

[ArtDisponible.Columnas]
0=85
1=95

[ArtPartidaAsignado.Columnas]
0=69
1=67
2=-2
3=-2
4=-2
5=-2

[ArtReservado.Columnas]
0=116
1=101

[ArtPartida.Columnas]
0=75
1=54
2=-2
3=-2
4=-2
5=-2

[Presupuesto.Columnas]
0=33
1=48
2=-2
3=-2
4=-2
5=-2








































































































































































































































































































[NegociaMoratoriosMAVI.Columnas]
Mov=124
MovID=117
ImporteReal=101
ImporteAPagar=104
ImporteMoratorio=113
MoratorioAPagar=104




















































































































































[Acciones.POSMonedero.ListaAccionesMultiples]
(Inicio)=POSMonedero
POSMonedero=Expresion
Expresion=(Fin)















































































[Acciones.Afectar.ValidaFacturasCredito]
Nombre=ValidaFacturasCredito
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Asigna(Temp.Logico,0)<BR>Asigna(Info.MovClaveAfecta, SQL(<T>SELECT mt.Clave FROM POSL p INNER JOIN MovTipo mt ON p.Mov = mt.Mov AND mt.Modulo = :tPOS WHERE p.ID = :tID<T>, <T>POS<T>, Info.IDTexto))<BR>Asigna(Temp.Logico, SQL(<T>EXEC spPOSFacturaCreditoCobro :tID<T>,  Info.IDTexto))<BR><BR>Si Info.MovClaveAfecta = <T>POS.P<T><BR>Entonces<BR> Si<BR>   Temp.Logico<BR> Entonces<BR>     Si Confirmacion(<T>Quiere realizar un abono a esta cuenta ?<T>, BotonSi, BotonNo) = BotonSi  Entonces FormaModal(<T>POSCobroFC<T>) Sino  AbortarOperacion   Fin<BR> Fin<BR>Fin

[Acciones.Encabezado.ListaAccionesMultiples]
(Inicio)=Forma
Forma=Expresion
Expresion=(Fin)



































[Acciones.BtnNuevo]
Nombre=BtnNuevo
Boton=0
NombreDesplegar=<T>Nuevo<T>
TipoAccion=Expresion
Visible=S







BarraBtnFondo=$00C08000
BarraBtnAncho=90
BarraBtnMargen=5
BarraBtnAlto=100
BarraBtnImgAncho=30
BarraBtnImgAlto=30
BarraBtnImgAlign=Derecha
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Izquierda
NombreEnBoton=S
NombreEnBotonX=S
edBotonSrc=Agregar.png
ConCondicion=S
EjecucionConError=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
BarraBtnPagina=1
Expresion=Asigna(Temp.Num, 0)<BR>Asigna(Info.Estatus,SQL(<T>SELECT Estatus FROM POSL WHERE ID = :tID<T>,Info.IDTexto))<BR>Si<BR>  Info.Estatus = Estatuspendiente<BR>Entonces<BR>  Asigna(Ver.Aviso,TextoEnLista(<T>Es Necesario Concluir o Eliminar El Movimiento<T>))<BR>Sino<BR>  Asigna(Info.Codigo, SQL(<T>SELECT MAX(Codigo) FROM CB WHERE Accion = :tAccion<T>, <T>MOVIMIENTO NUEVO<T>))<BR><BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>,<BR>                      EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>  Si ConDatos(Info.Observaciones)<BR>    Entonces Error( Info.Observaciones )<BR>  Sino <T><T><BR>  Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR><BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8]),<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen, Temp.Reg[11] )<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
Activo=S
EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>NO(Info.Cerrado)
EjecucionMensaje=<T>Caja Bloqueada<T>
[Acciones.BtnEncabezado]
Nombre=BtnEncabezado
Boton=0
NombreDesplegar=<T>Editar<BR>Encabezado<T>
Multiple=S
Activo=S
Visible=S

ListaAccionesMultiples=(Lista)
BarraBtnAncho=110
BarraBtnMargen=2
BarraBtnAlto=48
BarraBtnFondo=$00C08000
BarraBtnImgAncho=30
BarraBtnImgAlto=30
BarraBtnImgAlign=Derecha
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Izquierda
edBotonSrc=Encabezado.png
NombreEnBoton=S
NombreEnBotonX=S
ConCondicion=S
BarraBtnPagina=1
EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR>Asigna(Info.ABC, Nulo)<BR><BR>Si<BR>  SQL(<T>SELECT ISNULL(SinAutorizarEditarEncabezado,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>Entonces<BR>  Forma(<T>POSMovAutorizarSup<T>)<BR>Sino<BR>  Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>Fin<BR><BR><BR>Asigna(Ver.Todo,SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion(:tID, :tAccion)<T>,Info.IDTexto, <T>EDITAR ENCABEZADO<T>))<BR>Si((no(Ver.Todo ) y Info.Cerrado)o(Info.Cerrado y Ver.Todo ),Error(<T>Caja Bloqueada<T>))<BR><BR><BR>Si<BR>  Ver.Todo =  Verdadero<BR>Entonces<BR><BR> SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1<BR>Sino<BR>  Si((no(Ver.Todo))y (no(Info.Cerrado)),Precaucion(<T>Requiere Autorización<T>))<BR>Fin
[Acciones.BtnEncabezado.Forma]
Nombre=Forma
Boton=0
TipoAccion=Expresion
Activo=S
ConCondicion=S
EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))
Visible=S

[Acciones.BtnEncabezado.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=FormaModal(<T>POSL<T>)<BR><BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Info.Usuario,Usuario)<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Info.Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>Si ConDatos(Info.Observaciones)<BR>  Entonces Error( Info.Observaciones )<BR>Sino <T><T>                                                                                                             <BR>  Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>                                  <BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR><BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>EjecutarSQL(<T>spPOSUsuarioDesautoriza :tID<T>,Info.IDTexto)<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>
Activo=S
Visible=S







[Acciones.BtnDetalle]
Nombre=BtnDetalle
Boton=0
NombreDesplegar=<T>Editar<BR>Detalle<T>
Activo=S
Visible=S









BarraBtnAncho=110
BarraBtnMargen=2
BarraBtnAlto=48
BarraBtnFondo=$00C08000
BarraBtnImgAncho=30
BarraBtnImgAlto=30
BarraBtnImgAlign=Derecha
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Izquierda
edBotonSrc=Detalle.png
NombreEnBoton=S
NombreEnBotonX=S
TipoAccion=Expresion
ConCondicion=S
BarraBtnPagina=1
Expresion=Asigna(Info.Codigo, Nulo)<BR>FormaModal(<T>POSLVentaDev<T>)<BR>ActualizarVista<BR>ActualizarForma<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>Si ConDatos(Info.Observaciones)<BR>  Entonces Error( Info.Observaciones )<BR>Sino <T><T><BR>  Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR><BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>EjecutarSQL(<T>spPOSUsuarioDesautoriza :tID<T>,Info.IDTexto)<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR><BR>Asigna(Info.ABC, Nulo)<BR>Si<BR>  SQL(<T>SELECT ISNULL(SinAutorizarEditarDetalle,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>Entonces<BR>  Forma(<T>POSMovAutorizarSup<T>)<BR>Sino<BR>  Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>Fin<BR><BR>Si<BR>  SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1<BR>Entonces<BR>  Asigna(Info.MovClaveAfecta,SQL(<T>SELECT mt.Clave FROM MovTipo mt JOIN POSL p ON p.Mov = mt.Mov WHERE p.ID = :tID AND mt.Modulo = :tModulo<T>,Info.IDTexto,<T>POS<T>))<BR>  Si<BR>   Info.MovClaveAfecta en(<T>POS.F<T>, <T>POS.N<T>, <T>POS.NPC<T>, <T>POS.P<T>)<BR>  Entonces<BR>    Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>    Asigna(Ver.Todo,SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion(:tID, :tAccion)<T>,Info.IDTexto, <T>EDITAR DETALLE<T>))<BR>    Si<BR>      Ver.Todo y (Info.Cerrado = 0)<BR>    Entonces<BR>      (Precaucion(<T>Al Editar Detalle, no deberá añadir ningun articulo posterior,<BR>    de lo contrario se actualizarán los precios, descuentos y ofertas,<BR><BR>    ¿Desea Continuar?<T>, BotonSi, BotonNo)) = BotonSi<BR>    Sino<BR>      Si(Info.Cerrado,Error(<T>Caja Bloqueada<T>), Precaucion(<T>Requiere Autorización<T>))<BR>      Falso<BR>    Fin<BR>  Sino<BR>    Error(<T>Solo  es Posible Editar Movimientos de Venta<T>)<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin
[Acciones.BtnVerificarPrecios]
Nombre=BtnVerificarPrecios
Boton=0
NombreDesplegar=<T>Verificar<BR>Precios<T>
Activo=S
Visible=S













BarraBtnAncho=110
BarraBtnMargen=2
BarraBtnAlto=48
BarraBtnFondo=Turquesa
BarraBtnImgAncho=30
BarraBtnImgAlto=30
BarraBtnImgAlign=Derecha
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Izquierda
edBotonSrc=Verificar.png
NombreEnBoton=S
NombreEnBotonX=S
ConCondicion=S
EjecucionConError=S
TipoAccion=Expresion
BarraBtnPagina=1
Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion2(:tID, :tAccion)<T>,Info.IDTexto, <T>VERIFICAR PRECIOS<T>)<BR>Entonces<BR>  FormaModal(<T>POSVerificador<T>)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>NO(Info.Cerrado)
EjecucionMensaje=<T>Caja Bloqueada<T>
[Acciones.BtnReferenciaOrigen]
Nombre=BtnReferenciaOrigen
Boton=0
NombreDesplegar=<T>Referencia<BR>Origen<T>
Activo=S
Visible=S

BarraBtnAncho=110
BarraBtnMargen=2
BarraBtnAlto=48
BarraBtnFondo=Turquesa
BarraBtnImgAncho=30
BarraBtnImgAlto=30
BarraBtnImgAlign=Derecha
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Izquierda
edBotonSrc=Referencia.png
NombreEnBoton=S
NombreEnBotonX=S
ConCondicion=S
Antes=S
TipoAccion=Expresion
BarraBtnPagina=1
Expresion=FormaModal(<T>ReferenciaOrigen<T>)<BR>Asigna( Info.Codigo, Info.MovClaveAfecta+<T> <T>+Info.MovID)<BR><BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR><BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>/*Asigna(Ver.Saldo, TextoEnLista(Temp.Reg[10]))*/<BR><BR>/*Cuando hay una expresion de regreso la ejecuta*/<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>Si ConDatos(Ver.Expresion)<BR>Entonces Reexpresa( Ver.Expresion )<BR>Fin<BR>Asigna(Ver.Expresion, Nulo)<BR>Asigna(Info.Codigo, Nulo)<BR><BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.ABC, Nulo)<BR>Si<BR>  SQL(<T>SELECT ISNULL(SinAutorizarReferenciaOrigen,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>Entonces<BR>  Forma(<T>POSMovAutorizarSup<T>)<BR>Sino<BR>  Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>Fin<BR>SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1
AntesExpresiones=Asigna(Info.Codigo, nulo)
[Acciones.BtnDatosVuelo]
Nombre=BtnDatosVuelo
Boton=0
NombreDesplegar=<T>Vuelo<BR>(Duty Free)<T>
Visible=S





BarraBtnAncho=110
BarraBtnMargen=2
BarraBtnAlto=48
BarraBtnFondo=Turquesa
BarraBtnImgAncho=30
BarraBtnImgAlto=30
BarraBtnImgAlign=Derecha
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Izquierda
edBotonSrc=Vuelo.png
NombreEnBoton=S
NombreEnBotonX=S
ConCondicion=S
TipoAccion=Formas
Activo=S
ClaveAccion=DatosVueloDF
EjecucionConError=S
BarraBtnPagina=1
EjecucionCondicion=Asigna(Temp.Logico,SQL(<T>SELECT POSDutyFree FROM POSCfg WHERE Empresa=:tEmpresa<T>, Empresa))<BR>Temp.Logico
EjecucionMensaje=<T>Opción Deshabilitada<T>
[Acciones.BtnModificarAgente]
Nombre=BtnModificarAgente
Boton=0
NombreDesplegar=<T>Modificar<BR>Agente<T>
Activo=S
Visible=S









BarraBtnAncho=110
BarraBtnMargen=2
BarraBtnAlto=48
BarraBtnFondo=Turquesa
BarraBtnImgAncho=30
BarraBtnImgAlto=30
BarraBtnImgAlign=Derecha
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Izquierda
edBotonSrc=Agente.png
NombreEnBoton=S
NombreEnBotonX=S
TipoAccion=Expresion
BarraBtnPagina=1
Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion2(:tID, :tAccion)<T>,Info.IDTexto, <T>MODIFICAR AGENTE<T>)<BR>Entonces<BR>  Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>MODIFICAR AGENTE<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.TextoTemp02, nulo)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.BtnEliminarCaptura]
Nombre=BtnEliminarCaptura
Boton=0
NombreDesplegar=<T>Eliminar<BR>Captura<T>
Activo=S
Visible=S

BarraBtnAncho=110
BarraBtnMargen=2
BarraBtnAlto=48
BarraBtnFondo=$000080FF
BarraBtnImgAncho=30
BarraBtnImgAlto=30
BarraBtnImgAlign=Derecha
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Izquierda
edBotonSrc=Eliminar.png
NombreEnBoton=S
NombreEnBotonX=S
ConCondicion=S
Multiple=S
ListaAccionesMultiples=(Lista)
BarraBtnPagina=1
EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR>Asigna(Info.ABC, Nulo)<BR>Si<BR>  SQL(<T>SELECT ISNULL(SinAutorizarEliminarCaptura,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>Entonces<BR>  Forma(<T>POSMovAutorizarSup<T>)<BR>Sino<BR>  Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>Fin<BR>SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1
[Acciones.BtnModificarCantidad]
Nombre=BtnModificarCantidad
NombreDesplegar=<T>Modificar<BR>Cantidad<T>
Activo=S
Visible=S





BarraBtnAncho=110
BarraBtnMargen=2
BarraBtnAlto=48
BarraBtnFondo=$000080FF
BarraBtnImgAncho=30
BarraBtnImgAlto=30
BarraBtnImgAlign=Derecha
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Izquierda
Boton=0
edBotonSrc=Modificar.png
NombreEnBoton=S
NombreEnBotonX=S
TipoAccion=Expresion
BarraBtnPagina=1
Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion2(:tID, :tAccion)<T>,Info.IDTexto, <T>MODIFICAR CANTIDAD<T>)<BR>Entonces<BR>  Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>MODIFICAR CANTIDAD<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.TextoTemp02, nulo)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)

[BtnCategoria]
Estilo=Botones
Clave=BtnCategoria
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ArtCat
Fuente={Tahoma, 8, Negro, []}















































BarraBotones=S
ListaAccionesBB=(Lista)
BarraBotonesFuente={MS Sans Serif, 8, Negro, []}
BarraBotonesColor=$00C08000
BarraBotonesPosicion=Abajo
BarraBotonesImagenPosicion=Abajo
SizeBarraBotones=50
SizeBotonBarraBotones=115
BotonesTexto=Si(Vacio(ArtCat:ArtCat.Imagen),ArtCat:ArtCat.Categoria,<T><T>)
BotonesTextoFuente={Segoe UI, 10, Blanco, []}
BotonesColor=Turquesa
BotonesAncho=165
BotonesSeparacion=4
BotonesMargen=0
BotonesAlto=50
BotonesPanelColor=$00804000
BotonesPanelBisel=0
BotonesAccion=SelCategoria
BotonesSinBorde=S
BotonesBisel=0
BotonesImagenAlineacion=Centrado
BotonesImagenPosicion=Centrado
BotonesTextoPosicion=Arriba
BotonesTextoAlineacion=Centrado
OtroOrden=S
ListaOrden=ArtCat.Categoria<TAB>(Acendente)
Paginacion=S
PaginacionTamano=16
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=$00804000
BarraBtnPosicion=Abajo
BarraBtnSize=54
BarraBtnSeparacion=5
BarraBtnSinBisel=S
BarraBtnBisel=0

BotonesImagenAlto=50
BotonesImagenAncho=165


BotonesImagen=ArtCat:ArtCat.Imagen
PestanaNombre=Categorias
CondicionVisible=(SQL(<T>SELECT PanelAMostrar FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<><T>Imágenes<T>
[Ticket.ListaEnCaptura]
(Inicio)=Ver.Ticket
Ver.Ticket=Ver.TicketHTML
Ver.TicketHTML=(Fin)
















[Ticket.Ver.Ticket]
Carpeta=Ticket
Clave=Ver.Ticket
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




















[Acciones.Enter.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S






Expresion=Forma.ActualizarVista(<T>Ticket<T>)<BR>Forma.ActualizarVista(<T>Aviso<T>)<BR>Forma.ActualizarVista(<T>Imagen<T>)<BR>Forma.ActualizarVista(<T>Saldo<T>)<BR>Forma.ActualizarControles(<T>Ticket<T>)<BR>Forma.ActualizarControles(<T>Aviso<T>)<BR>Forma.ActualizarControles(<T>Imagen<T>)<BR>Forma.ActualizarControles(<T>Saldo<T>)
[BtnArticulo]
Estilo=Botones
Clave=BtnArticulo
BarraBotones=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=POSBtnArt
Fuente={Tahoma, 8, Negro, []}
BotonesTextoFuente={Segoe UI, 10, Blanco, []}
BotonesPanelColor=$00804000
BarraBtnFuente={Tahoma, 12, Blanco, []}
BarraBtnFondo=$00804000
CarpetaVisible=S

Filtros=S
BotonesTexto=Si(ConDatos(POSBtnArt:Imagen),<T><T>,POSBtnArt:Descripcion1)
BotonesColor=Turquesa
BotonesAncho=165
BotonesSeparacion=4
BotonesMargen=0
BotonesAlto=50
BotonesSinBorde=S
BotonesBisel=0
BotonesPanelBisel=0
BotonesImagenAlto=50
BotonesImagenAncho=165
BotonesImagenAlineacion=Centrado
BotonesImagenPosicion=Centrado
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
BarraBtnPosicion=Abajo
BarraBtnSize=54
BarraBtnSeparacion=5
BarraBtnSinBisel=S
BarraBtnBisel=0






OtroOrden=S
ListaOrden=NombreCorto<TAB>(Acendente)
Paginacion=S
PaginacionTamano=16
























































































































BotonesTextoPosicion=Arriba
BotonesTextoAlineacion=Centrado
ListaAccionesBB=(Lista)
BotonesAccion=SelArticulo

BotonesImagen=POSBtnArt:Imagen
PestanaNombre=Articulos
FiltroGeneral=Art.Categoria = <T>{ArtCat:ArtCat.Categoria}<T>
[Acciones.CatInicio]
Nombre=CatInicio
Boton=0
NombreDesplegar=<T>Inicio<T>
Carpeta=BtnCategoria
TipoAccion=Controles Captura
ClaveAccion=Pagina Inicial
Activo=S
Visible=S
BarraBtnAncho=50
BarraBtnMargen=2
BarraBtnAlto=50
BarraBtnFondo=$00C08000
BarraBtnImgAncho=50
BarraBtnImgAlto=50
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Centrado
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado




edBotonSrc=PaginaInicio.png
[Acciones.CatRetroceder]
Nombre=CatRetroceder
Boton=0
NombreDesplegar=<T>Retroceder<T>
Carpeta=BtnCategoria
TipoAccion=Controles Captura
ClaveAccion=Pagina Retroceder
Activo=S
Visible=S
BarraBtnAncho=50
BarraBtnMargen=2
BarraBtnAlto=50
BarraBtnFondo=$00C08000
BarraBtnImgAncho=50
BarraBtnImgAlto=50
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Centrado
BarraBtnTxtPos=Arriba
BarraBtnTxtAlign=Izquierda





edBotonSrc=PaginaAnterior.png
[Acciones.CatAvanzar]
Nombre=CatAvanzar
Boton=0
NombreDesplegar=<T>Avanzar<T>
Carpeta=BtnCategoria
TipoAccion=Controles Captura
ClaveAccion=Pagina Avanzar
Activo=S
Visible=S
BarraBtnAncho=50
BarraBtnMargen=2
BarraBtnAlto=50
BarraBtnFondo=$00C08000
BarraBtnImgAncho=50
BarraBtnImgAlto=50
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Centrado
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Izquierda






































































edBotonSrc=PaginaSiguiente.png
[Acciones.ArtCatRegresar]
Nombre=ArtCatRegresar
Boton=0
NombreDesplegar=<T>Inicio<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=$00C08000

BarraBtnAncho=50
BarraBtnMargen=2
BarraBtnAlto=50
BarraBtnImgAncho=50
BarraBtnImgAlto=50
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Centrado
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Izquierda

































edBotonSrc=Subir.png
Expresion=Forma.ActualizarVista(<T>BtnCategoria<T>)      <BR>Forma.IrCarpeta(<T>BtnCategoria<T>)
[Acciones.ArtInicio]
Nombre=ArtInicio
Boton=0
NombreDesplegar=<T>Inicio<T>
Carpeta=BtnArticulo
TipoAccion=Controles Captura
ClaveAccion=Pagina Inicial
Activo=S
Visible=S
BarraBtnAncho=50
BarraBtnMargen=2
BarraBtnAlto=50
BarraBtnFondo=$00C08000
BarraBtnImgAncho=50
BarraBtnImgAlto=50
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Centrado
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado





edBotonSrc=PaginaInicio.png
[Acciones.ArtRegresar]
Nombre=ArtRegresar
Boton=0
NombreDesplegar=<T>Regresar<T>
Carpeta=BtnArticulo
TipoAccion=Controles Captura
ClaveAccion=Pagina Retroceder
Activo=S
Visible=S
BarraBtnAncho=50
BarraBtnMargen=2
BarraBtnAlto=50
BarraBtnFondo=$00C08000
BarraBtnImgAncho=50
BarraBtnImgAlto=50
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Centrado









edBotonSrc=PaginaAnterior.png
[Acciones.ArtAvanzar]
Nombre=ArtAvanzar
Boton=0
NombreDesplegar=<T>Avanzar<T>
Carpeta=BtnArticulo
TipoAccion=Controles Captura
ClaveAccion=Pagina Avanzar
Activo=S
Visible=S
BarraBtnAncho=50
BarraBtnMargen=2
BarraBtnAlto=50
BarraBtnFondo=$00C08000
BarraBtnImgAncho=50
BarraBtnImgAlto=50
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Centrado










































edBotonSrc=PaginaSiguiente.png
[Acciones.SelCategoria]
Nombre=SelCategoria
Boton=0
NombreDesplegar=Seleccionar Categoria
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Asigna(Info.Categoria,ArtCat:ArtCat.Categoria)<BR>Forma.ActualizarVista(<T>BtnArticulo<T>)<BR>Forma.PaginaInicial(<T>BtnArticulo<T>)<BR>Forma.IrCarpeta(<T>BtnArticulo<T>)
BarraBtnFondo=Negro
[Acciones.SelArticulo]
Nombre=SelArticulo
Boton=0
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

ConCondicion=S
EjecucionConError=S

Antes=S
Expresion=Asigna(Info.Tipo,Nulo)<BR>Asigna(Info.Codigo,POSBtnArt:Articulo)<BR>Asigna(Info.Tipo,POSBtnArt:Tipo)<BR>Forma.Accion(<T>Enter<T>)
EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>No(Info.Cerrado)
EjecucionMensaje=<T>Caja Bloqueada<T>
AntesExpresiones=Asigna(Info.Articulo, POSBtnArt:Articulo)<BR>Asigna(Info.ArtTipo, POSBtnArt:Tipo)
[Acciones.SelOpcion]
Nombre=SelOpcion
Boton=0
NombreDesplegar=SeleccionarOpcion
TipoAccion=Expresion
Activo=S
Visible=S

















[Acciones.btnBuscarArticulo]
Nombre=btnBuscarArticulo
Boton=0
NombreDesplegar=<T>Buscar Articulo<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Blanco
BarraBtnAncho=35
BarraBtnMargen=5
BarraBtnAlto=70
BarraBtnImgAncho=25
BarraBtnImgAlto=25
edBotonSrc=BuscarAzul.png
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Centrado
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado





















ConCondicion=S
EjecucionConError=S
BarraBtnPagina=1
Expresion=FormaModal(<T>POSArtLista<T>)<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR><BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>/*Asigna(Ver.Saldo, TextoEnLista(Temp.Reg[10]))*/<BR><BR>/*Cuando hay una expresion de regreso la ejecuta*/<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>Si<BR>  ConDatos(Ver.Expresion)<BR>Entonces<BR>  Reexpresa( Ver.Expresion )<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>Fin<BR>Asigna(Ver.Expresion, Nulo)<BR>Asigna(Info.Codigo, Nulo)<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>NO(Info.Cerrado)
EjecucionMensaje=<T>Caja Bloqueada<T>
[Acciones.BtnInventario]
Nombre=BtnInventario
Boton=0
NombreDesplegar=<T>Consultar Inventario<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=35
BarraBtnMargen=5
BarraBtnAlto=70
BarraBtnFondo=Blanco
BarraBtnImgAncho=25
BarraBtnImgAlto=25
edBotonSrc=Infoazul.png
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Centrado
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado




























ConCondicion=S
BarraBtnPagina=1
Expresion=Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioAccion WHERE Usuario = :tUsuario AND Accion = :tAccion<T>, Usuario, <T>CONSULTAR INV<T>) = 1<BR>Entonces<BR>  Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CONSULTAR INV<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.TextoTemp02, nulo)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR>Forma(<T>POSMovAutorizarSup<T>)<BR>SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1
[Saldo.Ver.Total]
Carpeta=Saldo
Clave=Ver.Total
ValidaNombre=S
3D=N
Tamano=12
ColorFuente=Blanco
Efectos=[Negritas]




ColorFondo=$00804000




































Pegado=S







[Acciones.BtnEliminarCaptura.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S






Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion(:tID, :tAccion)<T>,Info.IDTexto, <T>ELIMINAR MOVIMIENTO<T>)<BR>Entonces<BR>  Asigna(Info.Codigo, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>ELIMINAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.BtnEliminarCaptura.Validadevolucion]
Nombre=Validadevolucion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Temp.Num, 0)
Activo=S
Visible=S







[Acciones.BtnEliminarCaptura.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S







[Acciones.BtnEliminarCaptura.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S



[Acciones.MenuPrincipal]
Nombre=MenuPrincipal
Boton=0
NombreDesplegar=<T>Menú<BR>Principal<T>
TipoAccion=Expresion
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
edBotonSrc=F1.png
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





NombreEnBoton=S
NombreEnBotonX=S



























BarraBtnPagina=1
TeclaFuncion=F1
Activo=S
Visible=S
Expresion=BarraIrPagina(<T>Saldo<T>,2)
[Acciones.MenuEdicion]
Nombre=MenuEdicion
Boton=0
NombreDesplegar=<T>Menú<BR>Edición<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=$00C08000

BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnImgAncho=40
BarraBtnImgAlto=40
edBotonSrc=F2.png
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





NombreEnBoton=S
NombreEnBotonX=S















BarraBtnPagina=1
TeclaFuncion=F2
Expresion=BarraIrPagina(<T>Saldo<T>,3)
[Acciones.MenuMovimientos]
Nombre=MenuMovimientos
Boton=0
NombreDesplegar=<T>Menú<BR>Movimientos<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado
NombreEnBoton=S
NombreEnBotonX=S






edBotonSrc=F3.png
BarraBtnPagina=1
TeclaFuncion=F3
Expresion=BarraIrPagina(<T>Saldo<T>,4)
[Acciones.MenuClientes]
Nombre=MenuClientes
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Menú<BR>Clientes<T>
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
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






BarraBtnPagina=1
TeclaFuncion=F4
Expresion=BarraIrPagina(<T>Saldo<T>,5)
[Acciones.Separador1]
Nombre=Separador1
Boton=0
EsSeparador=S
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro












[Acciones.MenuSupervisor]
Nombre=MenuSupervisor
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Menú<BR>Supervisor<T>
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
edBotonSrc=F5.png
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado














BarraBtnPagina=1
TeclaFuncion=F5
Expresion=BarraIrPagina(<T>Saldo<T>,6)
[Acciones.BuscaArticulo]
Nombre=BuscaArticulo
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Buscar<BR>Artículo<T>
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
edBotonSrc=F8.png
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






ConCondicion=S
EjecucionConError=S
BarraBtnPagina=1
TeclaFuncion=F8
Expresion=FormaModal(<T>POSArtLista<T>)<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR><BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>/*Asigna(Ver.Saldo, TextoEnLista(Temp.Reg[10]))*/<BR><BR>/*Cuando hay una expresion de regreso la ejecuta*/<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>Si<BR>  ConDatos(Ver.Expresion)<BR>Entonces<BR>  Reexpresa( Ver.Expresion )<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>Fin<BR>Asigna(Ver.Expresion, Nulo)<BR>Asigna(Info.Codigo, Nulo)<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>NO(Info.Cerrado)
EjecucionMensaje=<T>Caja Bloqueada<T>
[Acciones.EliminaCaptura]
Nombre=EliminaCaptura
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Eliminar<BR>Captura<T>
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
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

ConCondicion=S
Multiple=S
ListaAccionesMultiples=(Lista)
BarraBtnPagina=1
TeclaFuncion=F6
EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR>Asigna(Info.ABC, Nulo)<BR>Si<BR>  SQL(<T>SELECT ISNULL(SinAutorizarEliminarCaptura,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>Entonces<BR>  Forma(<T>POSMovAutorizarSup<T>)<BR>Sino<BR>  Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>Fin<BR><BR>SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1
[Acciones.ModificaCantidad]
Nombre=ModificaCantidad
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Modificar<BR>Cantidad<T>
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
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






TipoAccion=Expresion
ConCondicion=S
EjecucionConError=S
BarraBtnPagina=1
TeclaFuncion=F7
Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion2(:tID, :tAccion)<T>,Info.IDTexto, <T>MODIFICAR CANTIDAD<T>)<BR>Entonces<BR>  Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>MODIFICAR CANTIDAD<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.TextoTemp02, nulo)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>NO(Info.Cerrado)
EjecucionMensaje=<T>Caja Bloqueada<T>
[Acciones.Separador2]
Nombre=Separador2
Boton=0
NombreDesplegar=<T>Separador2<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro







[Acciones.BloqueaDesbloquea]
Nombre=BloqueaDesbloquea
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Bloquear / Desbloquear<T>
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
edBotonSrc=F10.png
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






BarraBtnPagina=1
TeclaFuncion=F10
Expresion=Asigna(Temp.Caja,SQL(<T>SELECT DefCtaDinero FROM Usuario WHERE Usuario = :tUsuario<T>, Usuario))<BR>Asigna(Temp.TextoTemp01,SQL(<T>SELECT HOST FROM POSiSync<T>))<BR>Asigna(Temp.POSCajaLogico, SQL(<T>SELECT Bloqueado FROM POSEstatusCaja WHERE Abierto = :nAbierto AND Caja = :Caja AND Usuario = :tUsuario AND HOST = :tHOST<T>, 1, Temp.Caja, Usuario, Temp.TextoTemp01))<BR><BR>FormaModal(<T>POSMovAutorizar<T>)<BR>Si<BR>  (Temp.POSCajaLogico = 0) y (Info.Usuario = SQL(<T>SELECT Usuario FROM POSEstatusCaja WHERE Abierto = :nAbierto AND Caja = :Caja AND Usuario = :tUsuario<T>, 1, Temp.Caja, Usuario))<BR>Entonces<BR>  Asigna(Temp.TextoTemp01,SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>BLOQUEAR CAJA<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp01, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>Sino<BR>  Asigna(Temp.TextoTemp01,SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>DESBLOQUEAR CAJA<T>))<BR>Fin<BR><BR><BR>Si<BR>  Info.Usuario = SQL(<T>SELECT Usuario FROM POSEstatusCaja WHERE Abierto = :nAbierto AND Caja = :Caja AND Usuario = :tUsuario<T>, 1, Temp.Caja, Usuario)<BR>Entonces<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp01, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>Sino<BR>  Informacion(<T>Cajero Incorrecto, para desbloquear la caja es necesario que se firme el Cajero: <T>+ Mayusculas(Usuario))<BR>Fin<BR><BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Asigna(Temp.TextoTemp01, nulo)<BR>Asigna(Temp.Caja, nulo)<BR>Asigna(Temp.TextoTemp01, nulo)<BR>Asigna(Temp.POSCajaLogico, 0)<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.SalirPOS]
Nombre=SalirPOS
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Salir POS<T>
TipoAccion=Ventana
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
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado




























ClaveAccion=Cerrar


BarraBtnPagina=1
TeclaFuncion=F11
[Acciones.Separador3]
Nombre=Separador3
Boton=0
NombreDesplegar=<T>Separador3<T>
EsSeparador=S
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=72
BarraBtnAlto=75
BarraBtnFondo=Negro


























[Acciones.AfectaMov]
Nombre=AfectaMov
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Afectar<BR>Movimiento<T>
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
edBotonSrc=F12.png
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





















ConCondicion=S
EjecucionConError=S






Multiple=S
ListaAccionesMultiples=(Lista)






BarraBtnPagina=1
TeclaFuncion=F12
EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>NO(Info.Cerrado)
EjecucionMensaje=<T>Caja Bloqueada<T>
[Acciones.AfectaMov.ValidarDetalle]
Nombre=ValidarDetalle
Boton=0
TipoAccion=Expresion
Activo=S
ConCondicion=S
EjecucionCondicion=Asigna(Info.SeCompra,SQL(<T>SELECT dbo.fnPOSValidaPOSLVenta(:tID)<T>,Info.IDTexto))<BR>Info.SeCompra
EjecucionMensaje=<T>No Hay Nada Que Afectar<T>
EjecucionConError=S
Visible=S
Expresion=EjecutarSQL(<T>EXEC spPOSConsecutivoAutoAsignaAntes :tID<T>, Info.IDTexto)






[Acciones.AfectaMov.ValidarSerie]
Nombre=ValidarSerie
Boton=0
TipoAccion=Expresion
Activo=S
ConCondicion=S
EjecucionConError=S
Visible=S

EjecucionCondicion=Asigna(Temp.Logico,SQL(<T>SELECT dbo.fnPOSValidaSerieLote(:tID)<T>,Info.IDTexto))<BR>No(Temp.Logico)
EjecucionMensaje=<T>Falta Indicar los Numeros de Serie/Lote<T>














[Acciones.AfectaMov.ValidaDevoluciones]
Nombre=ValidaDevoluciones
Boton=0
TipoAccion=Expresion
Expresion=Si<BR>  Temp.Num = 1<BR>Entonces<BR>  FormaModal(<T>POSLVentaDev<T>)<BR>Sino<BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR>Fin<BR><BR>Asigna(Temp.Num, 0)
Activo=S
Visible=S








[Acciones.AfectaMov.ValidaFacturasCredito]
Nombre=ValidaFacturasCredito
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Temp.Logico,0)<BR>Asigna(Info.MovClaveAfecta, SQL(<T>SELECT mt.Clave FROM POSL p INNER JOIN MovTipo mt ON p.Mov = mt.Mov AND mt.Modulo = :tPOS WHERE p.ID = :tID<T>, <T>POS<T>, Info.IDTexto))<BR>Asigna(Temp.Logico, SQL(<T>EXEC spPOSFacturaCreditoCobro :tID<T>,  Info.IDTexto))<BR><BR>Si Info.MovClaveAfecta = <T>POS.P<T><BR>Entonces<BR> Si<BR>   Temp.Logico<BR> Entonces<BR>     Si Confirmacion(<T>Quiere realizar un abono a esta cuenta ?<T>, BotonSi, BotonNo) = BotonSi  Entonces FormaModal(<T>POSCobroFC<T>) Sino  AbortarOperacion   Fin<BR> Fin<BR>Fin
Activo=S
Visible=S







[Acciones.AfectaMov.Afectar]
Nombre=Afectar
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.Numero,SQL(<T>spPOSInsertarCobroCondicionTemp :tID, :tEmpresa, :nEstacion, :nSucursal, :tUsuario<T>, Info.IDTexto, Empresa, EstacionTrabajo, Sucursal, Usuario)) Si (Info.Numero = 1)  Entonces     FormaModal(<T>POSCobroCondicionTemp<T>)   Fin<BR>Asigna(Info.MovClaveAfecta, SQL(<T>SELECT mt.Clave FROM POSL p INNER JOIN MovTipo mt ON p.Mov = mt.Mov AND mt.Modulo = :tPOS WHERE p.ID = :tID<T>, <T>POS<T>, Info.IDTexto))<BR>Asigna(Info.Mensaje,Nulo)<BR>Asigna(Info.IDTextoAnterior, Info.IDTexto)<BR>Asigna(Info.POSMonedero,Nulo)<BR>EjecutarSQL(<T>spPOSOfertaPuntosImporte :tEmpresa,:nEstacion,:tID<T>,Empresa, EstacionTrabajo, Info.IDTexto)<BR>Asigna(Info.POSRedondeo, SQL(<T>EXEC spPOSVentaInsertaRedondeo :tID, :tTipo<T>, Info.IDTexto, <T>SUGERIR<T>))<BR>Asigna(Info.POSRedondeo2,0.0)<BR>EjecutarSQL(<T>spPOSVentaInsertaRedondeo :tID,:tTipo,:nImporte<T>,Info.IDTexto,<T>ELIMINAR COBRO<T>,Nulo)<BR>Asigna(Info.Acumulativa,SQL(<T>SELECT RedondeoVenta FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa))<BR>Asigna(Info.Acumulativa,SQL(<T>SELECT dbo.fnPOSTieneServicioLDI(:tID, :lBit)<T>,Info.IDTexto, Info.Acumulativa))<BR>Si(Info.MovClaveAfecta=<T>POS.FA<T>,Asigna(Info.Acumulativa,0))<BR>Si(Info.MovClaveAfecta=<T>POS.CXCC<T>,Asigna(Info.Acumulativa,0))<BR>Si (Info.Importe >= 0)y(Info.MovClaveAfecta en(<T>POS.F<T>,<T>POS.N<T>,<T>POS.FA<T>,<T>POS.CXCC<T>))<BR>  Entonces<BR>    SI  Info.Acumulativa<BR>      Entonces<BR>        Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>       Asigna(Info.Saldo, Temp.Reg[9])<BR>       Asigna(Info.Importe, Temp.Reg[9])<BR>        FormaModal(<T>POSRedondeo<T>)<BR>      Sino<BR>        FormaModal(<T>POSCobro<T>)<BR>    Fin<BR>Sino<BR>  Si Info.MovClaveAfecta En( <T>POS.N<T>,<T>POS.CXCD<T>)<BR>    Entonces FormaModal(<T>POSCobroNegativo<T>)<BR>  Sino<BR>    Asigna(Info.Codigo, SQL(<T>SELECT Codigo FROM CB WHERE Accion = :tAccion<T>, <T>CONCLUIR MOVIMIENTO<T>))<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto, Info.Importe, Info.FormaPagoCambio, Info.Cambio, 0, Nulo, Nulo, Info.POSMonedero))<BR>    Asigna(Info.Codigo, Nulo)<BR>  Fin<BR>Fin<BR>Asigna(Info.POSImporteOferta,Nulo)<BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>/*Si ConDatos(Info.Observaciones)<BR>  Entonces Informacion(Info.Observaciones )<BR>Sino <T><T><BR>  Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR><BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>Asigna(Ver.Expresion2, TextoEnLista(Temp.Reg[20]))<BR>Si ConDatos(Ver.Expresion)<BR>Entonces Reexpresa( Ver.Expresion )<BR>Fin<BR>SI(ConDatos(Ver.Expresion2),Reexpresa( Ver.Expresion2 ))<BR><BR>Asigna(Ver.Expresion, Nulo)<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tFormaCambio, :nCambio, :nCobro, :nLecturaTarjeta, :tCliente, :tMonedero,:nImporteRef<T>, EstacionTrabajo, NULO, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto,Nulo, Info.FormaPagoCambio, Info.Cambio, 1, Nulo, Nulo, Info.POSMonedero,NULO))<BR><BR>Si(Info.MovClaveAfecta EN(<T>POS.N<T>,<T>POS.F<T>, <T>POS.CXCC<T>),Si(ConDatos(Info.Mensaje),Asigna(Ver.Aviso,Ver.Aviso+NuevaLinea+Info.Mensaje)))<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>/*Cuando hay una expresion de regreso la ejecuta*/<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>Asigna(Ver.Expresion2, TextoEnLista(Temp.Reg[20]))<BR>Si ConDatos(Ver.Expresion)<BR>Entonces Reexpresa( Ver.Expresion )<BR>Fin<BR>Asigna(Ver.Expresion, Nulo)<BR>Asigna(Ver.Expresion2, Nulo)<BR>Asigna(Info.POSRedondeo, nulo)<BR>Asigna(Temp.Logico,SQL(<T>SELECT POSDutyFree FROM POSCfg WHERE Empresa=:tEmpresa<T>, Empresa)) Si Temp.Logico Entonces Forma(<T>DatosVueloDF<T>) Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
Activo=S
Visible=S


[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=C1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaAlineacionDerecha=S
FichaColorFondo=Plata
Totalizadores=S
CampoColorLetras=Negro
CampoColorFondo=Negro
CarpetaVisible=S





























[Codigo.ListaEnCaptura]
(Inicio)=Info.Codigo
Info.Codigo=Info.Importe
Info.Importe=(Fin)




















































[Acciones.EliminaCaptura.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S






Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion(:tID, :tAccion)<T>,Info.IDTexto, <T>ELIMINAR MOVIMIENTO<T>)<BR>Entonces<BR>  Asigna(Info.Codigo, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>ELIMINAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.EliminaCaptura.ValidaDevolucion]
Nombre=ValidaDevolucion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Temp.Num, 0)
Activo=S
Visible=S







[Acciones.EliminaCaptura.ActualizarVista]
Nombre=ActualizarVista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.EliminaCaptura.ActualizarForma]
Nombre=ActualizarForma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S





[Acciones.RegresarPrincipal]
Nombre=RegresarPrincipal
Boton=0
NombreDesplegar=Regresar
Activo=S
Visible=S
BarraBtnAncho=72
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
edBotonSrc=Esc.png
BarraBtnPagina=2
NombreEnBoton=S
NombreEnBotonX=S
EsSeparador=S








[Acciones.NavegarMov]
Nombre=NavegarMov
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Movimientos Pendientes<T>
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
BarraBtnPagina=2
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado
















TeclaFuncion=F1
Expresion=Asigna(Info.Estatus,SQL(<T>SELECT Estatus FROM POSL WHERE ID = :tID<T>,Info.IDTexto))<BR>Si<BR>  Info.Estatus = Estatuspendiente<BR>Entonces<BR>  Asigna(Ver.Aviso,TextoEnLista(<T>Es Necesario Concluir o Eliminar El Movimiento<T>))<BR>Sino<BR>  Asigna(Info.IDTexto, SQL(<T>spPOSMovNavega :tID, :tUsuario<T>,  Info.IDTexto, Usuario))<BR>  Asigna(Info.Codigo, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia,  Info.IDTexto))<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>  Si ConDatos(Info.Observaciones)<BR>    Entonces Error( Info.Observaciones )<BR>  Sino <T><T><BR>  Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR><BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.ListaMov]
Nombre=ListaMov
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Lista de Movimientos<T>
TipoAccion=Formas
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
ClaveAccion=POSLLista
ConCondicion=S

EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR>Asigna(Info.ABC, Nulo)<BR>Si<BR>  SQL(<T>SELECT ISNULL(SinAutorizarListaMov,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>Entonces<BR>  Forma(<T>POSMovAutorizarSup<T>)<BR>Sino<BR>  Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>Fin<BR><BR>SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1
[Acciones.ConsultaInvenatario]
Nombre=ConsultaInvenatario
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Consultar Inventario<T>
TipoAccion=Expresion
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F6.png
BarraBtnPagina=2
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






TeclaFuncion=F6
ConCondicion=S
EjecucionConError=S
Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion2(:tID, :tAccion)<T>,Info.IDTexto, <T>CONSULTAR INV<T>)<BR>Entonces<BR>  Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CONSULTAR INV<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.TextoTemp02, nulo)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
ActivoCondicion=0
EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR>Asigna(Info.ABC, Nulo)<BR>Si<BR>  SQL(<T>SELECT ISNULL(SinAutorizarConsultaInv,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>Entonces<BR>  Forma(<T>POSMovAutorizarSup<T>)<BR>Sino<BR>  Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>Fin<BR><BR>SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1
EjecucionMensaje=<T>Caja Bloqueada<T>
VisibleCondicion=0
[Acciones.Separador4]
Nombre=Separador4
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro






BarraBtnPagina=2
[Acciones.ReversaPago]
Nombre=ReversaPago
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Reversar Pago<T>
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
BarraBtnPagina=2
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado
















TeclaFuncion=F3
ConCondicion=S

Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion(:tID, :tAccion)<T>,Info.IDTexto, <T>REVERSAR COBRO<T>)<BR>Entonces<BR>  Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>REVERSAR COBRO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  //Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.TextoTemp02, nulo)<BR>  Forma(<T>POSCBFormaPagoRC<T>)<BR>  Forma.Accion(<T>Enter<T>)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR>Asigna(Info.ABC, Nulo)<BR>Si<BR>  SQL(<T>SELECT ISNULL(SinAutorizarReversarPago,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>Entonces<BR>  Forma(<T>POSMovAutorizarSup<T>)<BR>Sino<BR>  Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>Fin<BR><BR>SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1
[Acciones.AltaMonedero]
Nombre=AltaMonedero
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Alta Monedero<T>
TipoAccion=Expresion
Activo=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F5.png
BarraBtnPagina=2
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





















TeclaFuncion=F5
Expresion=Si<BR>  SQL(<T>SELECT POSMonedero FROM POSCfg WHERE Empresa = :tEmpresa<T>,Empresa)=0<BR>Entonces<BR>  FormaModal(<T>POSMonedero<T>)<BR>  Forma.Accion(<T>CalculaImporteRefPrevio<T>)<BR>Sino<BR>  Informacion(<T>Opción no disponible<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
VisibleCondicion=Temp.POSMonederoL o Info.MonederoCB
[Acciones.RegresarP3]
Nombre=RegresarP3
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Regresar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=72
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

TeclaFuncion=Esc
Expresion=BarraIrPagina(<T>Saldo<T>,1)
[Acciones.RegresarP2]
Nombre=RegresarP2
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Regresar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=72
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











TeclaFuncion=Esc
Expresion=BarraIrPagina(<T>Saldo<T>,1)
[Acciones.MovNuevo]
Nombre=MovNuevo
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Nuevo<T>
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
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






TeclaFuncion=F1
ConCondicion=S
EjecucionConError=S
Expresion=Asigna(Temp.Num, 0)<BR>Asigna(Info.Estatus,SQL(<T>SELECT Estatus FROM POSL WHERE ID = :tID<T>,Info.IDTexto))<BR>Si<BR>  Info.Estatus = Estatuspendiente<BR>Entonces<BR>  Asigna(Ver.Aviso,TextoEnLista(<T>Es Necesario Concluir o Eliminar El Movimiento<T>))<BR>Sino<BR>  Asigna(Info.Codigo, SQL(<T>SELECT MAX(Codigo) FROM CB WHERE Accion = :tAccion<T>, <T>MOVIMIENTO NUEVO<T>))<BR><BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>,<BR>                      EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Info.Codigo, Nulo)<BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>  Si ConDatos(Info.Observaciones)<BR>    Entonces Error( Info.Observaciones )<BR>  Sino <T><T><BR>  Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR><BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8]),<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen, Temp.Reg[11] )<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>NO(Info.Cerrado)
EjecucionMensaje=<T>Caja Bloqueada<T>
[Acciones.EditarEncabezado]
Nombre=EditarEncabezado
Boton=0
NombreDesplegar=<T>Editar Encabezado<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
edBotonSrc=F2.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado
NombreEnBoton=S
NombreEnBotonX=S






TeclaFuncion=F2
ConCondicion=S
Expresion=FormaModal(<T>POSL<T>)<BR><BR>Asigna(Info.Codigo, Nulo)<BR>Asigna(Info.Usuario,Usuario)<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Info.Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>Si ConDatos(Info.Observaciones)<BR>  Entonces Error( Info.Observaciones )<BR>Sino <T><T>                                                                                                             <BR>  Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>                                  <BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR><BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>EjecutarSQL(<T>spPOSUsuarioDesautoriza :tID<T>,Info.IDTexto)<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR><BR>Si<BR>  SQL(<T>SELECT ISNULL(SinAutorizarEditarEncabezado,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>Entonces<BR>  Forma(<T>POSMovAutorizarSup<T>)<BR>Sino<BR>  Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>Fin<BR><BR><BR>Asigna(Ver.Todo,SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion(:tID, :tAccion)<T>,Info.IDTexto, <T>EDITAR ENCABEZADO<T>))<BR>Si((no(Ver.Todo ) y Info.Cerrado)o(Info.Cerrado y Ver.Todo ),Error(<T>Caja Bloqueada<T>))<BR><BR><BR>Si<BR>  Ver.Todo =  Verdadero<BR>Entonces<BR><BR> SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1<BR>Sino<BR>  Si((no(Ver.Todo))y (no(Info.Cerrado)),Precaucion(<T>Requiere Autorización<T>))<BR>Fin
[Acciones.EditarDetalle]
Nombre=EditarDetalle
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Editar Detalle<T>
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
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F3
ConCondicion=S
Expresion=Asigna(Info.Codigo, Nulo)<BR>FormaModal(<T>POSLVentaDev<T>)<BR>ActualizarVista<BR>ActualizarForma<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>Si ConDatos(Info.Observaciones)<BR>  Entonces Error( Info.Observaciones )<BR>Sino <T><T><BR>  Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR><BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))  <BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>EjecutarSQL(<T>spPOSUsuarioDesautoriza :tID<T>,Info.IDTexto)<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR>Asigna(Info.ABC, Nulo)                                             <BR><BR>Si<BR>  SQL(<T>SELECT ISNULL(SinAutorizarEditarDetalle,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>Entonces<BR>  Forma(<T>POSMovAutorizarSup<T>)<BR>Sino<BR>  Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>Fin<BR><BR>Si<BR>  SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1<BR>Entonces<BR>  Asigna(Info.MovClaveAfecta,SQL(<T>SELECT mt.Clave FROM MovTipo mt JOIN POSL p ON p.Mov = mt.Mov WHERE p.ID = :tID AND mt.Modulo = :tModulo<T>,Info.IDTexto,<T>POS<T>))<BR>  Si<BR>   Info.MovClaveAfecta en(<T>POS.F<T>, <T>POS.N<T>, <T>POS.NPC<T>, <T>POS.P<T>)<BR>  Entonces<BR>    Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>    Asigna(Ver.Todo,SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion(:tID, :tAccion)<T>,Info.IDTexto, <T>EDITAR DETALLE<T>))<BR>    Si<BR>      Ver.Todo y (Info.Cerrado = 0)<BR>    Entonces<BR>      (Precaucion(<T>Al Editar Detalle, no deberá añadir ningun articulo posterior,<BR>    de lo contrario se actualizarán los precios, descuentos y ofertas,<BR><BR>    ¿Desea Continuar?<T>, BotonSi, BotonNo)) = BotonSi<BR>    Sino<BR>      Si(Info.Cerrado,Error(<T>Caja Bloqueada<T>), Precaucion(<T>Requiere Autorización<T>))<BR>      Falso<BR>    Fin<BR>  Sino<BR>    Error(<T>Solo  es Posible Editar Movimientos de Venta<T>)<BR>  Fin<BR>Sino<BR>  <T><T><BR>Fin
[Acciones.VerificaPrecio]
Nombre=VerificaPrecio
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Verificar Precio<T>
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
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F4
ConCondicion=S
EjecucionConError=S
Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion2(:tID, :tAccion)<T>,Info.IDTexto, <T>VERIFICAR PRECIOS<T>)<BR>Entonces<BR>  FormaModal(<T>POSVerificador<T>)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>NO(Info.Cerrado)
EjecucionMensaje=<T>Caja Bloqueada<T>
[Acciones.Separador5]
Nombre=Separador5
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=3

[Acciones.RefOrigen]
Nombre=RefOrigen
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Referencia Origen<T>
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
edBotonSrc=F5.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F5
ConCondicion=S
Antes=S

Expresion=FormaModal(<T>ReferenciaOrigen<T>)<BR>Asigna( Info.Codigo, Info.MovClaveAfecta+<T> <T>+Info.MovID)<BR><BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto))<BR><BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>/*Asigna(Ver.Saldo, TextoEnLista(Temp.Reg[10]))*/<BR><BR>/*Cuando hay una expresion de regreso la ejecuta*/<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>Si ConDatos(Ver.Expresion)<BR>Entonces Reexpresa( Ver.Expresion )<BR>Fin<BR>Asigna(Ver.Expresion, Nulo)<BR>Asigna(Info.Codigo, Nulo)<BR><BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.ABC, Nulo)<BR>Si<BR>  SQL(<T>SELECT ISNULL(SinAutorizarReferenciaOrigen,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>Entonces<BR>  Forma(<T>POSMovAutorizarSup<T>)<BR>Sino<BR>  Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>Fin<BR><BR>SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1
AntesExpresiones=Asigna(Info.Codigo, nulo)
[Acciones.ModificaAgente]
Nombre=ModificaAgente
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Modificar Agente<T>
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
edBotonSrc=F6.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado











TeclaFuncion=F6
Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion2(:tID, :tAccion)<T>,Info.IDTexto, <T>MODIFICAR AGENTE<T>)<BR>Entonces<BR>  Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>MODIFICAR AGENTE<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.TextoTemp02, nulo)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.RegresarP4]
Nombre=RegresarP4
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Regresar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
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












TeclaFuncion=Esc
Expresion=BarraIrPagina(<T>Saldo<T>,1)
[Acciones.UsuarioAutoriza]
Nombre=UsuarioAutoriza
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Factura Anticipo<T>
TipoAccion=Expresion
Visible=S
BarraBtnAncho=75
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

TeclaFuncion=F1
ConCondicion=S
EjecucionConError=S
Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilMov2(:tID, :tMov)<T>,Info.IDTexto, <T>Factura Anticipo<T>)<BR>Entonces<BR>  Asigna(Info.Mov, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CAMBIAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Mov,  SQL(<T>SELECT m.Orden FROM POSUsuarioMov p JOIN MovTipo m ON p.Mov = m.Mov WHERE m.Modulo=:tm  AND p.Usuario =:tu AND p.Mov =:tMov<T>, <T>POS<T>, Usuario , <T>Factura Anticipo<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.Codigo, nulo)<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Asigna(Info.Cliente,Nulo)<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Ver.Expresion, Nulo)<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta, :tCliente<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo, Info.Cliente))<BR>    Asigna(Info.Cliente,Nulo)<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso al movimiento<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
ActivoCondicion=Pos.WebService
EjecucionCondicion=SQL(<T>SELECT dbo.fnPOSValidarCteMost(:tCliente)<T>, Info.Cliente) <> 1 y<BR>(Si<BR> SQL(<T>spPOSEstadoCaja :tID, :tUsuario<T>, Info.IDTexto, Usuario) = 1<BR>Entonces<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>  Asigna(Info.Usuario, Nulo)<BR>  Asigna(Info.Contrasena, Nulo)<BR>  Asigna(Info.ABC, Nulo)<BR>  Si<BR>    SQL(<T>SELECT ISNULL(SinAutorizarFacturaAnticipo,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>  Entonces<BR>    Forma(<T>POSMovAutorizarSup<T>)<BR>  Sino<BR>    Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>    EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>  Fin<BR><BR>  SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1<BR>Sino<BR>Informacion(<T>LA CAJA ESTA CERRADA... VERIFIQUE......<T> )<BR>Fin)
EjecucionMensaje=<T>No puede generar un crédito al Cliente Mostrador<T>
[Acciones.MovNota]
Nombre=MovNota
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Nota<T>
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
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






TeclaFuncion=F2
Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilMov2(:tID, :tMov)<T>,Info.IDTexto, <T>Nota<T>)<BR>Entonces<BR>  Asigna(Info.Mov, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CAMBIAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Mov,  SQL(<T>SELECT m.Orden FROM POSUsuarioMov p JOIN MovTipo m ON p.Mov = m.Mov WHERE m.Modulo=:tm  AND p.Usuario =:tu AND p.Mov =:tMov<T>, <T>POS<T>, Usuario , <T>Nota<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.Codigo, nulo)<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Asigna(Info.Cliente,Nulo)<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Ver.Expresion, Nulo)<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta, :tCliente<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo, Info.Cliente))<BR>    Asigna(Info.Cliente,Nulo)<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso al movimiento<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.MovFacturaCredito]
Nombre=MovFacturaCredito
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Factura Crédito<T>
TipoAccion=Expresion
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






TeclaFuncion=F3
ConCondicion=S
EjecucionConError=S
Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilMov2(:tID, :tMov)<T>,Info.IDTexto, <T>Factura Credito<T>)<BR>Entonces<BR>  Asigna(Info.Mov, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CAMBIAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Mov,  SQL(<T>SELECT m.Orden FROM POSUsuarioMov p JOIN MovTipo m ON p.Mov = m.Mov WHERE m.Modulo=:tm  AND p.Usuario =:tu AND p.Mov =:tMov<T>, <T>POS<T>, Usuario , <T>Factura Credito<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.Codigo, nulo)<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Asigna(Info.Cliente,Nulo)<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Ver.Expresion, Nulo)<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta, :tCliente<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo, Info.Cliente))<BR>    Asigna(Info.Cliente,Nulo)<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso al movimiento<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
ActivoCondicion=Pos.WebService
EjecucionCondicion=SQL(<T>SELECT dbo.fnPOSValidarCteMost(:tCliente)<T>, Info.Cliente) y<BR>(Si<BR> SQL(<T>spPOSEstadoCaja :tID, :tUsuario<T>, Info.IDTexto, Usuario) = 1<BR>Entonces<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>  Asigna(Info.Usuario, Nulo)<BR>  Asigna(Info.Contrasena, Nulo)<BR>  Asigna(Info.ABC, Nulo)<BR>  Si<BR>    SQL(<T>SELECT ISNULL(SinAutorizarFacturaCredito,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>  Entonces<BR>    Forma(<T>POSMovAutorizarSup<T>)<BR>  Sino<BR>    Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>    EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>  Fin<BR>  SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1<BR>Sino<BR>Informacion(<T>LA CAJA ESTA CERRADA... VERIFIQUE......<T> )<BR>Fin)
EjecucionMensaje=<T>No puede generar un Crédito al Cliente seleccionado<T>
[Acciones.MovCobroCred]
Nombre=MovCobroCred
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Cobro Crédito<T>
TipoAccion=Expresion
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






TeclaFuncion=F4
ConCondicion=S
EjecucionConError=S
Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilMov2(:tID, :tMov)<T>,Info.IDTexto, <T>Cobro Credito<T>)<BR>Entonces<BR>  Asigna(Info.Mov, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CAMBIAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Mov,nulo)<BR>  Asigna(Info.Mov,  SQL(<T>SELECT m.Orden FROM POSUsuarioMov p JOIN MovTipo m ON p.Mov = m.Mov WHERE m.Modulo=:tm  AND p.Usuario =:tu AND p.Mov =:tMov<T>, <T>POS<T>, Usuario , <T>Cobro Credito<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR><BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.Codigo, nulo)<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si <BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Asigna(Info.Cliente,Nulo)<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Ver.Expresion, Nulo)<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta, :tCliente<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo, Info.Cliente))<BR>    Asigna(Info.Cliente,Nulo)<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR><BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso al movimiento<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
ActivoCondicion=Pos.WebService
EjecucionCondicion=SQL(<T>SELECT dbo.fnPOSValidarCteMost(:tCliente)<T>, Info.Cliente)  y<BR>(Si<BR> SQL(<T>spPOSEstadoCaja :tID, :tUsuario<T>, Info.IDTexto, Usuario) = 1<BR>Entonces<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>  Asigna(Info.Usuario, Nulo)<BR>  Asigna(Info.Contrasena, Nulo)<BR>  Asigna(Info.ABC, Nulo)<BR>  Si<BR>    SQL(<T>SELECT ISNULL(SinAutorizarCobroCredito,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>  Entonces<BR>    Forma(<T>POSMovAutorizarSup<T>)<BR>  Sino<BR>    Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>    EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>  Fin<BR>  SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1<BR>Sino<BR>Informacion(<T>LA CAJA ESTA CERRADA... VERIFIQUE......<T> )<BR>Fin)
EjecucionMensaje=<T>No se puede realizar un Cobro Crédito al Cliente seleccionado<T>
[Acciones.Separador6]
Nombre=Separador6
Boton=0
EsSeparador=S
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnImgAncho=40
BarraBtnImgAlto=40
BarraBtnPagina=4

[Acciones.MovPedido]
Nombre=MovPedido
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Pedido<T>
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
edBotonSrc=F5.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






TeclaFuncion=F5
Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilMov2(:tID, :tMov)<T>,Info.IDTexto, <T>Pedido<T>)<BR>Entonces<BR>  Asigna(Info.Mov, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CAMBIAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Mov,  SQL(<T>SELECT m.Orden FROM POSUsuarioMov p JOIN MovTipo m ON p.Mov = m.Mov WHERE m.Modulo=:tm  AND p.Usuario =:tu AND p.Mov =:tMov<T>, <T>POS<T>, Usuario , <T>Pedido<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.Codigo, nulo)<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Asigna(Info.Cliente,Nulo)<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Ver.Expresion, Nulo)<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta, :tCliente<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo, Info.Cliente))<BR>    Asigna(Info.Cliente,Nulo)<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso al movimiento<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.MovDevolucion]
Nombre=MovDevolucion
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Devolución<T>
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
edBotonSrc=F6.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






TeclaFuncion=F6
ConCondicion=S
Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion2(:tID, :tAccion)<T>,Info.IDTexto, <T>DEVOLUCION TOTAL<T>)<BR>Entonces<BR><BR>  Si      <BR>    Confirmacion( <T>¿Que se incluyan Articulos Ofertados en la Venta Original?<T>, BotonSi, BotonNo ) = BotonSi    <BR>  Entonces      <BR>    EjecutarSQL(<T>spPOSDevTotalBit :tID, :nOfertado<T>, Info.IDTexto, 1)<BR>  Sino      <BR>    EjecutarSQL(<T>spPOSDevTotalBit :tID, :nOfertado<T>, Info.IDTexto, 0)    <BR>  Fin  <BR><BR>  Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>DEVOLUCION TOTAL<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])     <BR>  Asigna(Temp.TextoTemp02, nulo)<BR><BR>Sino<BR>  Informacion(<T>El usuario no tiene acceso a la acción<T>)<BR>Fin<BR><BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR>Asigna(Info.ABC, Nulo)<BR>Si<BR>  SQL(<T>SELECT ISNULL(SinAutorizarDevolucion,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>Entonces<BR>  Forma(<T>POSMovAutorizarSup<T>)<BR>Sino<BR>  Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>Fin<BR>SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1
[Acciones.MovDevParcial]
Nombre=MovDevParcial
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Devolución Parcial<T>
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
edBotonSrc=F7.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






TeclaFuncion=F7
ConCondicion=S
Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion2(:tID, :tAccion)<T>,Info.IDTexto, <T>DEVOLUCION PARCIAL<T>)<BR>Entonces<BR><BR>  Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>DEVOLUCION PARCIAL<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.TextoTemp02, nulo)<BR><BR>Sino<BR>  Informacion(<T>El usuario no tiene acceso a la acción<T>)<BR>Fin<BR><BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR>Asigna(Info.ABC, Nulo)<BR>Si<BR>  SQL(<T>SELECT ISNULL(SinAutorizarDevolucionParcial,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>Entonces<BR>  Forma(<T>POSMovAutorizarSup<T>)<BR>Sino<BR>  Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>Fin<BR>SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1
EjecucionMensaje=<T>Caja bloqueada<T>
[Acciones.MovFormaEnvio]
Nombre=MovFormaEnvio
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Forma Envío<T>
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
edBotonSrc=F8.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F8
ConCondicion=S
Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion2(:tID, :tAccion)<T>,Info.IDTexto, <T>FORMA ENVIO<T>)<BR>Entonces<BR>  Asigna(Info.Codigo, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>FORMA ENVIO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.Codigo, nulo)<BR>Sino<BR>  Informacion(<T>El usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR>Asigna(Info.ABC, Nulo)<BR>Si<BR>  SQL(<T>SELECT ISNULL(SinAutorizarFormaEnvio,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>Entonces<BR>  Forma(<T>POSMovAutorizarSup<T>)<BR>Sino<BR>  Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>Fin<BR>SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1
EjecucionMensaje=<T>Caja bloqueada<T>
[Acciones.Separador7]
Nombre=Separador7
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=4

[Acciones.LlamaPedido]
Nombre=LlamaPedido
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Llamar Pedidos<T>
TipoAccion=Expresion
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F9.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






TeclaFuncion=F9
ConCondicion=S
Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion2(:tID, :tAccion)<T>,Info.IDTexto, <T>FACTURAR PEDIDO<T>)<BR>Entonces<BR>  Asigna(Info.Codigo, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>FACTURAR PEDIDO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.Codigo, nulo)<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Asigna(Info.Cliente,Nulo)<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Ver.Expresion, Nulo)<BR>    //Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta, :tCliente<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo, Info.Cliente))<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta, :tCliente<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo, Nulo))<BR>    Asigna(Info.Cliente,Nulo)<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>Sino<BR>  Informacion(<T>El usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
ActivoCondicion=Pos.WebService
EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR>Asigna(Info.ABC, Nulo)<BR>Si<BR>  SQL(<T>SELECT ISNULL(SinAutorizarLlamarPedidos,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>Entonces<BR>  Forma(<T>POSMovAutorizarSup<T>)<BR>Sino<BR>  Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>Fin<BR>SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1
EjecucionMensaje=<T>Caja bloqueada<T>
[Acciones.LlamaAnticipo]
Nombre=LlamaAnticipo
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Llamar Anticipo<T>
TipoAccion=Expresion
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F10.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F10
ConCondicion=S
Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion2(:tID, :tAccion)<T>,Info.IDTexto, <T>ANTICIPOS FACTURADOS<T>)<BR>Entonces<BR>  Asigna(Info.Codigo, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>ANTICIPOS FACTURADOS<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.Codigo, nulo)<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Asigna(Info.Cliente,Nulo)<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Ver.Expresion, Nulo)<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta, :tCliente<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo, Info.Cliente))<BR>    Asigna(Info.Cliente,Nulo)<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>Sino<BR>  Informacion(<T>El usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
ActivoCondicion=Pos.WebService
EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR>Asigna(Info.ABC, Nulo)<BR>Si<BR>  SQL(<T>SELECT ISNULL(SinAutorizarLlamarAnticipo,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>Entonces<BR>  Forma(<T>POSMovAutorizarSup<T>)<BR>Sino<BR>  Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>Fin<BR>SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1
EjecucionMensaje=<T>Caja bloqueada<T>
[Acciones.MovPendiente]
Nombre=MovPendiente
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Buscar Mov Pendientes<T>
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
edBotonSrc=F11.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






TeclaFuncion=F11
Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion2(:tID, :tAccion)<T>,Info.IDTexto, <T>BUSCAR MOVIMIENTO<T>)<BR>Entonces<BR>  Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>BUSCAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR> Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.TextoTemp02, nulo)<BR>Sino<BR>  Informacion(<T>El usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.MovNotaxCobrar]
Nombre=MovNotaxCobrar
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Nota x Cobrar<T>
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
edBotonSrc=F12.png
BarraBtnPagina=4
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






TeclaFuncion=F12
Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilMov2(:tID, :tMov)<T>,Info.IDTexto, <T>Nota Por Cobrar<T>)<BR>Entonces<BR>  Asigna(Info.Mov, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CAMBIAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Mov,  SQL(<T>SELECT m.Orden FROM POSUsuarioMov p JOIN MovTipo m ON p.Mov = m.Mov WHERE m.Modulo=:tm  AND p.Usuario =:tu AND p.Mov =:tMov<T>, <T>POS<T>, Usuario , <T>Nota Por Cobrar<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Info.Codigo, nulo)<BR>  Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>  Si<BR>    ConDatos(Ver.Expresion)<BR>  Entonces<BR>    Asigna(Info.Cliente,Nulo)<BR>    Reexpresa( Ver.Expresion )<BR>    Asigna(Ver.Expresion, Nulo)<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta, :tCliente<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo, Info.Cliente))<BR>    Asigna(Info.Cliente,Nulo)<BR>    Asigna(Info.IDTexto, Temp.Reg[1])<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    SI(Vacio(Ver.Aviso),Asigna(Ver.Aviso,Ver.Memo))<BR>  Fin<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso al movimiento<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.RegresarP5]
Nombre=RegresarP5
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Regresar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
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











TeclaFuncion=Esc
Expresion=BarraIrPagina(<T>Saldo<T>,1)
[Acciones.ModDatosCte]
Nombre=ModDatosCte
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Modificar Cliente<T>
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
BarraBtnPagina=5
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F1
ConCondicion=S
Expresion=Asigna(Info.Cliente, SQL(<T>SELECT Cliente FROM POSL WHERE ID = :tID<T>, Info.IDTexto))<BR>Asigna(CteX.Nombre, SQL(<T>SELECT Nombre FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))<BR>Asigna(CteX.Direccion, SQL(<T>SELECT Direccion FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))<BR>Asigna(CteX.DireccionNumero, SQL(<T>SELECT DireccionNumero FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))<BR>Asigna(CteX.DireccionNumeroInt, SQL(<T>SELECT DireccionNumeroInt FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))<BR>Asigna(CteX.EntreCalles, SQL(<T>SELECT EntreCalles FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))<BR>Asigna(CteX.Delegacion, SQL(<T>SELECT Delegacion FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))<BR>Asigna(CteX.Colonia, SQL(<T>SELECT Colonia FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))<BR>Asigna(CteX.Poblacion, SQL(<T>SELECT Poblacion FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))<BR>Asigna(CteX.Estado, SQL(<T>SELECT Estado FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))<BR>Asigna(CteX.Pais, SQL(<T>SELECT Pais FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))<BR>Asigna(CteX.CP, SQL(<T>SELECT CodigoPostal FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))<BR>Asigna(CteX.RFC, SQL(<T>SELECT RFC FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))<BR>Asigna(CteX.CURP, SQL(<T>SELECT CURP FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))<BR>Asigna(CteX.Contacto, SQL(<T>SELECT Contacto1 FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))<BR>Asigna(CteX.Email, SQL(<T>SELECT Email1 FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))<BR>Asigna(CteX.ZonaImpuesto, SQL(<T>SELECT ZonaImpuesto FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))<BR>Asigna(CteX.FechaNacimiento, SQL(<T>SELECT FechaNacimiento FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))                  <BR>Asigna(CteX.EstadoCivil, SQL(<T>SELECT EstadoCivil FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))                  <BR>Asigna(CteX.Conyuge, SQL(<T>SELECT Conyuge FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))                  <BR>Asigna(CteX.Sexo, SQL(<T>SELECT Sexo FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))                  <BR>Asigna(CteX.Fuma, SQL(<T>SELECT Fuma FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))                  <BR>Asigna(CteX.Profesion, SQL(<T>SELECT Profesion FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))<BR>Asigna(CteX.Puesto, SQL(<T>SELECT Puesto FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))                  <BR>Asigna(CteX.NumeroHijos, SQL(<T>SELECT NumeroHijos FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))                  <BR>Asigna(CteX.Religion, SQL(<T>SELECT Religion FROM Cte WHERE Cliente = :tCliente<T>, Info.Cliente))  <BR>FormaModal(<T>POSCteExpress<T>)<BR><BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCCambio, :nICambio, :nCobro, :tLectTarj, :tClliente<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo, Info.Cliente))<BR><BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR><BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR>Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])                                       <BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>/*Asigna(Ver.Saldo, TextoEnLista(Temp.Reg[10]))*/<BR><BR>/*Cuando hay una expresion de regreso la ejecuta*/<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>Si ConDatos(Ver.Expresion)<BR>Entonces Reexpresa( Ver.Expresion )<BR>Fin<BR>Asigna(Ver.Expresion, Nulo)<BR>Asigna(Info.Codigo, Nulo)<BR><BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR>Asigna(Info.ABC, Nulo)<BR>Si<BR>  SQL(<T>SELECT ISNULL(SinAutorizarDatosCliente,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>Entonces<BR>  Forma(<T>POSMovAutorizarSup<T>)<BR>Sino<BR>  Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>Fin<BR>SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1
EjecucionMensaje=<T>Caja bloqueada<T>
[Acciones.AgregaCliente]
Nombre=AgregaCliente
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Agregar Cliente<T>
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
BarraBtnPagina=5
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F2
ConCondicion=S
Expresion=Asigna(CteX.Nombre, Nulo)<BR>Asigna(CteX.Direccion, Nulo)<BR>Asigna(CteX.DireccionNumero, Nulo)<BR>Asigna(CteX.DireccionNumeroInt, Nulo)<BR>Asigna(CteX.EntreCalles, Nulo)<BR>Asigna(CteX.Delegacion, Nulo)<BR>Asigna(CteX.Colonia, Nulo)<BR>Asigna(CteX.Poblacion, Nulo)<BR>Asigna(CteX.Estado, Nulo)                          <BR>Asigna(CteX.Pais, Nulo)<BR>Asigna(CteX.CP, Nulo)<BR>Asigna(CteX.RFC, Nulo)<BR>Asigna(CteX.CURP, Nulo)<BR>Asigna(CteX.Contacto, Nulo)<BR>Asigna(CteX.Email, Nulo)<BR>Asigna(CteX.ZonaImpuesto,Nulo)<BR>Asigna(CteX.FechaNacimiento,Nulo)<BR>Asigna(CteX.EstadoCivil,Nulo)   <BR>Asigna(CteX.Conyuge,Nulo)    <BR>Asigna(CteX.Sexo,Nulo)    <BR>Asigna(CteX.Fuma,Nulo)<BR>Asigna(CteX.Profesion,Nulo)   <BR>Asigna(CteX.Puesto,Nulo)   <BR>Asigna(CteX.NumeroHijos,Nulo)<BR>Asigna(CteX.Religion,Nulo)<BR><BR>FormaModal(<T>POSCteExpressNuevo<T>)<BR><BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCCambio, :nICambio, :nCobro, :tLectTarj, :tClliente<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo, Info.Cliente))<BR><BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR><BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR>Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>/*Asigna(Ver.Saldo, TextoEnLista(Temp.Reg[10]))*/<BR><BR>/*Cuando hay una expresion de regreso la ejecuta*/<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>Si ConDatos(Ver.Expresion)<BR>Entonces Reexpresa( Ver.Expresion )<BR>Fin<BR>Asigna(Ver.Expresion, Nulo)<BR>Asigna(Info.Codigo, Nulo)<BR><BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR>Asigna(Info.ABC, Nulo)<BR>Si<BR>  SQL(<T>SELECT ISNULL(SinAutorizarAgregarCliente,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>Entonces<BR>  Forma(<T>POSMovAutorizarSup<T>)<BR>Sino<BR>  Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>Fin<BR>SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1
EjecucionMensaje=<T>Caja bloqueada<T>
[Acciones.BuscaCliente]
Nombre=BuscaCliente
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Buscar Cliente<T>
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
BarraBtnPagina=5
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado











TeclaFuncion=F3
Antes=S
Expresion=FormaModal(<T>POSCliente<T>)<BR><BR>Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta, :tCliente<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo, Info.Cliente))<BR><BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR><BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR>Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>/*Asigna(Ver.Saldo, TextoEnLista(Temp.Reg[10]))*/<BR><BR>/*Cuando hay una expresion de regreso la ejecuta*/<BR>Asigna(Ver.Expresion, TextoEnLista(Temp.Reg[7]))<BR>Si ConDatos(Ver.Expresion)<BR>Entonces Reexpresa( Ver.Expresion )<BR>Fin<BR>Asigna(Ver.Expresion, Nulo)<BR>Asigna(Info.Codigo, Nulo)<BR><BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
AntesExpresiones=EjecutarSQL(<T>spPOSAccionReferenciaPedido :tEmpresa, :nSucursal, :tUsuario, :nEstacion,  :tIDPOS<T>,Empresa, Sucursal, Usuario, EstacionTrabajo,  Info.IDTexto)
[Acciones.ClienteInfo]
Nombre=ClienteInfo
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Información Cliente<T>
TipoAccion=Expresion
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



TeclaFuncion=F4
Expresion=Asigna(Info.Cliente, SQL(<T>SELECT Cliente FROM POSL WHERE ID = :tID<T>, Info.IDTexto))<BR>Forma(<T>POSCteInfo<T>)<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
ActivoCondicion=Pos.WebService
[Forma.MenuPrincipal]
(Inicio)=Menú Principal &.
Menú Principal &.=Menú Edición
Menú Edición=Menú Movimientos
Menú Movimientos=Menú Clientes
Menú Clientes=Menú Supervisor
Menú Supervisor=(Fin)









[Acciones.Eliminar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=ValidaDevolucion
ValidaDevolucion=Actualizar Vista
Actualizar Vista=Actualizar Forma
Actualizar Forma=(Fin)













[Acciones.CancelarPartida.ListaAccionesMultiples]
(Inicio)=expresion
expresion=Actualizar Vista
Actualizar Vista=Actualizar Forma
Actualizar Forma=(Fin)

















[Acciones.Afectar.ListaAccionesMultiples]
(Inicio)=ValidarDetalle
ValidarDetalle=ValidarSeries
ValidarSeries=ValidaDevoluciones
ValidaDevoluciones=ValidaFacturasCredito
ValidaFacturasCredito=Afectar
Afectar=(Fin)








[Acciones.RegresarP6]
Nombre=RegresarP6
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Regresar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=Esc.png
BarraBtnPagina=6
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





TeclaFuncion=Esc
Expresion=BarraIrPagina(<T>Saldo<T>,1)
[Acciones.VerValores]
Nombre=VerValores
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Ver Valores<T>
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
BarraBtnPagina=6
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F1
ConCondicion=S
Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion2(:tID, :tAccion)<T>,Info.IDTexto, <T>VER CORTE CAJA<T>)<BR>Entonces<BR>  Forma(<T>PosVerValores<T>)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR>Asigna(Info.ABC, Nulo)<BR>Si<BR>  SQL(<T>SELECT ISNULL(SinAutorizarVerValores,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>Entonces<BR>  Forma(<T>POSMovAutorizarSup<T>)<BR>Sino<BR>  Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>Fin<BR>SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1
[Acciones.AperturaCaja]
Nombre=AperturaCaja
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Apertura de Caja<T>
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
BarraBtnPagina=6
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F2
ConCondicion=S
Expresion=Asigna(Info.Mov, SQL(<T>SELECT AperturaCaja FROM POSMovMenuSupervision WHERE Empresa = :tEmpresa<T>, Info.Empresa))<BR><BR>Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioMov WHERE Mov = :tMov AND Usuario = :tUsuario<T>, Info.Mov, Usuario) = 1<BR>Entonces<BR><BR>  Asigna(Info.Mov, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CAMBIAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Mov, SQL(<T>SELECT AperturaCaja FROM POSMovMenuSupervision WHERE Empresa = :tEmpresa<T>, Info.Empresa))<BR>  Asigna(Info.Mov, SQL(<T>SELECT m.Orden FROM POSUsuarioMov p JOIN MovTipo m ON p.Mov = m.Mov WHERE m.Modulo=:tm  AND p.Usuario =:tu AND p.Mov =:tMov<T>, <T>POS<T>, Usuario , Info.Mov))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Info.CtaDinero, SQL(<T>SELECT NULLIF(DefCtaDineroTrans, :tnulo) FROM Usuario WHERE Usuario =:tu<T>, <T> <T>,Usuario ))<BR>  Si<BR>    Info.CtaDinero = nulo<BR>  Entonces<BR>    Asigna(Temp.Numerico5,1)<BR>    Precaucion(<T>El Usuario no se tiene una Cuenta de Dinero configurada<T>)<BR>  Sino<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.CtaDinero, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Temp.TextoTemp01, SQL(<T>SELECT F8 FROM POSCobroFormasPago WHERE Empresa = :tEmpresa AND Sucursal = :tSucursal<T>, Info.Empresa, Sucursal))<BR>  Asigna(Temp.TextoTemp01, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND FormaPago = :tFormaPago<T>, <T>Forma Pago<T>, Temp.TextoTemp01))<BR><BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp01, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>  Si<BR>    ConDatos(Info.Observaciones)<BR>  Entonces<BR>    Informacion( Info.Observaciones )<BR>  Sino<BR>    <T><T><BR>  Fin<BR><BR>  Forma(<T>PosMenuEspecialSupervicion<T>)<BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR>  Asigna(Info.IDTexto, SQL(<T>spPOSAbrir :tEmpresa, :tUsuario<T>, Empresa,Usuario))<BR>  EjecutarSQL(<T>spPOSInicializar  :tEmpresa, :nSucursal, :tUsuario, :nEstacion, :tID<T>,Empresa, Sucursal, Usuario, EstacionTrabajo, Info.IDTexto)<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen, Temp.Reg[11])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR><BR>  Forma.AsignarAnuncios(Ver.Imagen,Info.POSPublicidad ,5 )<BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR> Fin<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso al Movimiento<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=Si<BR> SQL(<T>spPOSEstadoCaja :tID, :tUsuario<T>, Info.IDTexto, Usuario) = 0<BR>Entonces<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>  Asigna(Info.Usuario, Nulo)<BR>  Asigna(Info.Contrasena, Nulo)<BR>  Asigna(Info.ABC, Nulo)<BR>  Si<BR>    SQL(<T>SELECT ISNULL(SinAutorizarAperturaCaja,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>  Entonces<BR>    Forma(<T>POSMovAutorizarSup<T>)<BR>  Sino<BR>    Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>    EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>  Fin<BR>  SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1<BR>Sino<BR>Informacion(<T>LA CAJA YA ESTA ABIERTA... VERIFIQUE......<T> )<BR>Fin
[Acciones.AumentoCaja]
Nombre=AumentoCaja
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Aumento Caja<T>
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
BarraBtnPagina=6
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F3
ConCondicion=S
Expresion=Asigna(Info.Mov, SQL(<T>SELECT AumentoCaja FROM POSMovMenuSupervision WHERE Empresa = :tEmpresa<T>, Info.Empresa))<BR><BR>Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioMov WHERE Mov = :tMov AND Usuario = :tUsuario<T>, Info.Mov, Usuario) = 1<BR>Entonces<BR>  Asigna(Info.Mov, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CAMBIAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Mov, SQL(<T>SELECT AumentoCaja FROM POSMovMenuSupervision WHERE Empresa = :tEmpresa<T>, Info.Empresa))<BR>  Asigna(Info.Mov, SQL(<T>SELECT m.Orden FROM POSUsuarioMov p JOIN MovTipo m ON p.Mov = m.Mov WHERE m.Modulo=:tm  AND p.Usuario =:tu AND p.Mov =:tMov<T>, <T>POS<T>, Usuario , Info.Mov))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Info.CtaDinero, SQL(<T>SELECT NULLIF(DefCtaDineroTrans, :tnulo) FROM Usuario WHERE Usuario =:tu<T>, <T> <T>,Usuario ))<BR>  Si<BR>    Info.CtaDinero = nulo<BR>  Entonces<BR>    Asigna(Temp.Numerico5,1)<BR>    Precaucion(<T>El Usuario no se tiene una Cuenta de Dinero configurada<T>)<BR>  Sino<BR><BR><BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.CtaDinero, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Temp.TextoTemp01, SQL(<T>SELECT DefFormaPago FROM Usuario WHERE Usuario = :tUsuario<T>, Usuario ))<BR>  Asigna(Temp.TextoTemp01, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND FormaPago = :tFormaPago<T>, <T>Forma Pago<T>, Temp.TextoTemp01))<BR><BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp01, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>  Si<BR>    ConDatos(Info.Observaciones)<BR>  Entonces<BR>    Informacion( Info.Observaciones )<BR>  Sino<BR>    <T><T><BR>  Fin<BR>  Forma(<T>PosMenuEspecialSupervicion<T>)<BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR>  Asigna(Info.IDTexto, SQL(<T>spPOSAbrir :tEmpresa, :tUsuario<T>, Empresa,Usuario))<BR>  EjecutarSQL(<T>spPOSInicializar  :tEmpresa, :nSucursal, :tUsuario, :nEstacion, :tID<T>,Empresa, Sucursal, Usuario, EstacionTrabajo, Info.IDTexto)<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen, Temp.Reg[11])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR><BR>  Forma.AsignarAnuncios(Ver.Imagen,Info.POSPublicidad ,5 )<BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR> Fin<BR>Sino<BR>  Informacion(<T>El usuario no tiene acceso al movimiento<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=Si<BR> SQL(<T>spPOSEstadoCaja :tID, :tUsuario<T>, Info.IDTexto, Usuario) = 1<BR>Entonces<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>  Asigna(Info.Usuario, Nulo)<BR>  Asigna(Info.Contrasena, Nulo)<BR>  Asigna(Info.ABC, Nulo)<BR>  Si<BR>    SQL(<T>SELECT ISNULL(SinAutorizarAumentoCaja,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>  Entonces<BR>    Forma(<T>POSMovAutorizarSup<T>)<BR>  Sino<BR>    Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>    EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>  Fin<BR>  SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1<BR>Sino<BR>Informacion(<T>LA CAJA ESTA CERRADA... VERIFIQUE......<T> )<BR>Fin
[Acciones.CorteParcial]
Nombre=CorteParcial
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Corte Parcial<T>
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
BarraBtnPagina=6
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F4
ConCondicion=S
Expresion=Asigna(Info.Mov, SQL(<T>SELECT CorteParcialCaja FROM POSMovMenuSupervision WHERE Empresa = :tEmpresa<T>, Info.Empresa))<BR><BR>Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioMov WHERE Mov = :tMov AND Usuario = :tUsuario<T>, Info.Mov, Usuario) = 1<BR>Entonces<BR>  Asigna(Info.Mov, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CAMBIAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Mov, SQL(<T>SELECT CorteParcialCaja FROM POSMovMenuSupervision WHERE Empresa = :tEmpresa<T>, Info.Empresa))<BR>  Asigna(Info.Mov, SQL(<T>SELECT m.Orden FROM POSUsuarioMov p JOIN MovTipo m ON p.Mov = m.Mov WHERE m.Modulo=:tm  AND p.Usuario =:tu AND p.Mov =:tMov<T>, <T>POS<T>, Usuario , Info.Mov))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Info.CtaDinero, SQL(<T>SELECT NULLIF(DefCtaDineroTrans, :tnulo) FROM Usuario WHERE Usuario =:tu<T>, <T> <T>,Usuario ))<BR>  Si<BR>    Info.CtaDinero = nulo<BR>  Entonces<BR>    Asigna(Temp.Numerico5,2)<BR>    Precaucion(<T>El Usuario no se tiene una Cuenta de Dinero configurada<T>)<BR>  Sino<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.CtaDinero, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>    Si<BR>      ConDatos(Info.Observaciones)<BR>    Entonces<BR>      Informacion( Info.Observaciones )<BR>    Sino<BR>      <T><T><BR>    Fin<BR><BR>    Forma(<T>PosMenuEspecialSupervicion<T>)<BR><BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR>  Asigna(Info.IDTexto, SQL(<T>spPOSAbrir :tEmpresa, :tUsuario<T>, Empresa,Usuario))<BR>  EjecutarSQL(<T>spPOSInicializar  :tEmpresa, :nSucursal, :tUsuario, :nEstacion, :tID<T>,Empresa, Sucursal, Usuario, EstacionTrabajo, Info.IDTexto)<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen, Temp.Reg[11])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR><BR>  Forma.AsignarAnuncios(Ver.Imagen,Info.POSPublicidad ,5 )<BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR> Fin<BR>Sino                                       <BR>  Informacion(<T>El usuario no tiene acceso al movimiento<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=Si<BR> SQL(<T>spPOSEstadoCaja :tID, :tUsuario<T>, Info.IDTexto, Usuario) = 1<BR>Entonces<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>  Asigna(Info.Usuario, Nulo)<BR>  Asigna(Info.Contrasena, Nulo)<BR>  Asigna(Info.ABC, Nulo)<BR>  Si<BR>    SQL(<T>SELECT ISNULL(SinAutorizarCorteParcial,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>  Entonces<BR>    Forma(<T>POSMovAutorizarSup<T>)<BR>  Sino<BR>    Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>    EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>  Fin<BR>  SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1<BR>Sino<BR>Informacion(<T>LA CAJA ESTA CERRADA... VERIFIQUE......<T> )<BR>Fin
[Acciones.Separador8]
Nombre=Separador8
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=6

[Acciones.CorteCaja]
Nombre=CorteCaja
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Corte Caja<T>
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
edBotonSrc=F5.png
BarraBtnPagina=6
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F5
ConCondicion=S
Expresion=Asigna(Info.Mov, SQL(<T>SELECT CorteCaja FROM POSMovMenuSupervision WHERE Empresa = :tEmpresa<T>, Info.Empresa))<BR><BR>Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioMov WHERE Mov = :tMov AND Usuario = :tUsuario<T>, Info.Mov, Usuario) = 1<BR>Entonces<BR>  Asigna(Info.Mov, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CAMBIAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Mov, SQL(<T>SELECT CorteCaja FROM POSMovMenuSupervision WHERE Empresa = :tEmpresa<T>, Info.Empresa))<BR>  Asigna(Info.Mov, SQL(<T>SELECT m.Orden FROM POSUsuarioMov p JOIN MovTipo m ON p.Mov = m.Mov WHERE m.Modulo=:tm  AND p.Usuario =:tu AND p.Mov =:tMov<T>, <T>POS<T>, Usuario , Info.Mov))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Info.CtaDinero, SQL(<T>SELECT NULLIF(DefCtaDineroTrans, :tnulo) FROM Usuario WHERE Usuario =:tu<T>, <T> <T>,Usuario ))<BR>  Si<BR>    Info.CtaDinero = nulo<BR>  Entonces<BR>    Asigna(Temp.Numerico5,2)<BR>    Precaucion(<T>El Usuario no se tiene una Cuenta de Dinero configurada<T>)<BR>  Sino<BR><BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.CtaDinero, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>    Asigna(Temp.TextoTemp01, SQL(<T>SELECT F8 FROM POSCobroFormasPago WHERE Empresa = :tEmpresa AND Sucursal = :tSucursal<T>, Info.Empresa, Sucursal))<BR>    Asigna(Temp.TextoTemp01, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND FormaPago = :tFormaPago<T>, <T>Forma Pago<T>, Temp.TextoTemp01))<BR><BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp01, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>   Si<BR>     ConDatos(Info.Observaciones)<BR>    Entonces<BR>      Informacion( Info.Observaciones )<BR>   Sino<BR>    <T><T><BR>   Fin<BR>  Forma(<T>PosMenuEspecialSupervicion<T>)<BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR>  Asigna(Info.IDTexto, SQL(<T>spPOSAbrir :tEmpresa, :tUsuario<T>, Empresa,Usuario))<BR>  EjecutarSQL(<T>spPOSInicializar  :tEmpresa, :nSucursal, :tUsuario, :nEstacion, :tID<T>,Empresa, Sucursal, Usuario, EstacionTrabajo, Info.IDTexto)<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen, Temp.Reg[11])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR><BR>  Forma.AsignarAnuncios(Ver.Imagen,Info.POSPublicidad ,5 )<BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR> Fin<BR>Sino<BR>  Informacion(<T>El usuario no tiene acceso al movimiento<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=Si<BR> SQL(<T>spPOSEstadoCaja :tID, :tUsuario<T>, Info.IDTexto, Usuario) = 1<BR>Entonces<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>  Asigna(Info.Usuario, Nulo)<BR>  Asigna(Info.Contrasena, Nulo)<BR>  Asigna(Info.ABC, Nulo)<BR>  Si<BR>    SQL(<T>SELECT ISNULL(SinAutorizarCorteCaja,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>  Entonces<BR>    Forma(<T>POSMovAutorizarSup<T>)<BR>  Sino<BR>    Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>    EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>  Fin<BR>  SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1<BR>Sino<BR>Informacion(<T>LA CAJA ESTA CERRADA... VERIFIQUE......<T> )<BR>Fin
[Acciones.Egreso]
Nombre=Egreso
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Egreso<T>
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
edBotonSrc=F6.png
BarraBtnPagina=6
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado



TeclaFuncion=F6

ConCondicion=S
Expresion=Asigna(Info.Mov, SQL(<T>SELECT Egreso FROM POSMovMenuSupervision WHERE Empresa = :tEmpresa<T>, Info.Empresa))<BR><BR>Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioMov WHERE Mov = :tMov AND Usuario = :tUsuario<T>, Info.Mov, Usuario) = 1<BR>Entonces<BR>  Asigna(Info.Mov, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CAMBIAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Info.Mov, SQL(<T>SELECT Egreso FROM POSMovMenuSupervision WHERE Empresa = :tEmpresa<T>, Info.Empresa))<BR>  Asigna(Info.Mov, SQL(<T>SELECT m.Orden FROM POSUsuarioMov p JOIN MovTipo m ON p.Mov = m.Mov WHERE m.Modulo=:tm  AND p.Usuario =:tu AND p.Mov =:tMov<T>, <T>POS<T>, Usuario , Info.Mov))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>  Si<BR>    ConDatos(Info.Observaciones)<BR>  Entonces <BR>    Informacion( Info.Observaciones )<BR>  Sino <BR>    <T><T><BR>  Fin<BR><BR>  Forma(<T>PosMenuEspecialSupervicion<T>)<BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR>  Asigna(Info.IDTexto, SQL(<T>spPOSAbrir :tEmpresa, :tUsuario<T>, Empresa,Usuario))<BR>  EjecutarSQL(<T>spPOSInicializar  :tEmpresa, :nSucursal, :tUsuario, :nEstacion, :tID<T>,Empresa, Sucursal, Usuario, EstacionTrabajo, Info.IDTexto)<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen, Temp.Reg[11])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR><BR>  Forma.AsignarAnuncios(Ver.Imagen,Info.POSPublicidad ,5 )<BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR>Sino<BR>  Informacion(<T>El usuario no tiene acceso al movimiento<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=Si<BR> SQL(<T>spPOSEstadoCaja :tID, :tUsuario<T>, Info.IDTexto, Usuario) = 1<BR>Entonces<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>  Asigna(Info.Usuario, Nulo)<BR>  Asigna(Info.Contrasena, Nulo)<BR>  Asigna(Info.ABC, Nulo)<BR>  Si<BR>    SQL(<T>SELECT ISNULL(SinAutorizarEgreso,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>  Entonces<BR>    Forma(<T>POSMovAutorizarSup<T>)<BR>  Sino<BR>    Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>    EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>  Fin<BR>  SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1<BR>Sino<BR>Informacion(<T>LA CAJA ESTA CERRADA... VERIFIQUE......<T> )<BR>Fin
[Acciones.Ingreso]
Nombre=Ingreso
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Ingreso<T>
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
edBotonSrc=F7.png
BarraBtnPagina=6
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





TeclaFuncion=F7
ConCondicion=S

Expresion=Asigna(Info.Mov, SQL(<T>SELECT Ingreso FROM POSMovMenuSupervision WHERE Empresa = :tEmpresa<T>, Info.Empresa))<BR><BR>Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioMov WHERE Mov = :tMov AND Usuario = :tUsuario<T>, Info.Mov, Usuario) = 1<BR>Entonces<BR>  Asigna(Info.Mov, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CAMBIAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Info.Mov, SQL(<T>SELECT Ingreso FROM POSMovMenuSupervision WHERE Empresa = :tEmpresa<T>, Info.Empresa))<BR>  Asigna(Info.Mov, SQL(<T>SELECT m.Orden FROM POSUsuarioMov p JOIN MovTipo m ON p.Mov = m.Mov WHERE m.Modulo=:tm  AND p.Usuario =:tu AND p.Mov =:tMov<T>, <T>POS<T>, Usuario , Info.Mov))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>  Si <BR>    ConDatos(Info.Observaciones)<BR>  Entonces <BR>    Informacion( Info.Observaciones )<BR>  Sino <BR>    <T><T><BR>  Fin<BR><BR>  Forma(<T>PosMenuEspecialSupervicion<T>)<BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR>  Asigna(Info.IDTexto, SQL(<T>spPOSAbrir :tEmpresa, :tUsuario<T>, Empresa,Usuario))<BR>  EjecutarSQL(<T>spPOSInicializar  :tEmpresa, :nSucursal, :tUsuario, :nEstacion, :tID<T>,Empresa, Sucursal, Usuario, EstacionTrabajo, Info.IDTexto)<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen, Temp.Reg[11])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR><BR>  Forma.AsignarAnuncios(Ver.Imagen,Info.POSPublicidad ,5 )<BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso al Movimiento<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=Si<BR> SQL(<T>spPOSEstadoCaja :tID, :tUsuario<T>, Info.IDTexto, Usuario) = 1<BR>Entonces<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>  Asigna(Info.Usuario, Nulo)<BR>  Asigna(Info.Contrasena, Nulo)<BR>  Asigna(Info.ABC, Nulo)<BR>  Si<BR>    SQL(<T>SELECT ISNULL(SinAutorizarIngreso,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>  Entonces<BR>    Forma(<T>POSMovAutorizarSup<T>)<BR>  Sino<BR>    Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>    EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>  Fin<BR>  SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1<BR>Sino<BR>Informacion(<T>LA CAJA ESTA CERRADA... VERIFIQUE......<T> )<BR>Fin
[Acciones.AperturaCajaMM]
Nombre=AperturaCajaMM
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Apertura de Caja Multimoneda<T>
TipoAccion=Expresion
Activo=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=30
BarraBtnImgAlto=30
NombreEnBotonX=S
edBotonSrc=F8.png
BarraBtnPagina=6
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado













TeclaFuncion=F8
ConCondicion=S
Expresion=Asigna(Info.Mov, SQL(<T>SELECT AperturaCajaM FROM POSMovMenuSupervision WHERE Empresa = :tEmpresa<T>, Info.Empresa))<BR><BR>Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioMov WHERE Mov = :tMov AND Usuario = :tUsuario<T>, Info.Mov, Usuario) = 1<BR>Entonces<BR><BR>  Asigna(Info.Mov, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CAMBIAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Mov, SQL(<T>SELECT AperturaCajaM FROM POSMovMenuSupervision WHERE Empresa = :tEmpresa<T>, Info.Empresa))<BR>  Asigna(Info.Mov, SQL(<T>SELECT m.Orden FROM POSUsuarioMov p JOIN MovTipo m ON p.Mov = m.Mov WHERE m.Modulo=:tm  AND p.Usuario =:tu AND p.Mov =:tMov<T>, <T>POS<T>, Usuario , Info.Mov))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Info.CtaDinero, SQL(<T>SELECT NULLIF(DefCtaDineroTrans, :tnulo) FROM Usuario WHERE Usuario =:tu<T>, <T> <T>,Usuario ))<BR>  Si<BR>    Info.CtaDinero = nulo<BR>  Entonces<BR>    Asigna(Temp.Numerico5,1)<BR>    Precaucion(<T>El Usuario no se tiene una Cuenta de Dinero configurada<T>)<BR>  Sino<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.CtaDinero, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Temp.TextoTemp01, SQL(<T>SELECT F8 FROM POSCobroFormasPago WHERE Empresa = :tEmpresa AND Sucursal = :tSucursal<T>, Info.Empresa, Sucursal))<BR>  Asigna(Temp.TextoTemp01, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND FormaPago = :tFormaPago<T>, <T>Forma Pago<T>, Temp.TextoTemp01))<BR><BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp01, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>  Si<BR>    ConDatos(Info.Observaciones)<BR>  Entonces<BR>    Informacion( Info.Observaciones )<BR>  Sino<BR>    <T><T><BR>  Fin<BR><BR>  Forma(<T>PosMenuEspecialSupervicion<T>)<BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR>  Asigna(Info.IDTexto, SQL(<T>spPOSAbrir :tEmpresa, :tUsuario<T>, Empresa,Usuario))<BR>  EjecutarSQL(<T>spPOSInicializar  :tEmpresa, :nSucursal, :tUsuario, :nEstacion, :tID<T>,Empresa, Sucursal, Usuario, EstacionTrabajo, Info.IDTexto)<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen, Temp.Reg[11])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR><BR>  Forma.AsignarAnuncios(Ver.Imagen,Info.POSPublicidad ,5 )<BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR> Fin<BR>Sino<BR>  Informacion(<T>El usuario no tiene acceso al movimiento<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=Si<BR> SQL(<T>spPOSEstadoCaja :tID, :tUsuario<T>, Info.IDTexto, Usuario) = 0<BR>Entonces<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>  Asigna(Info.Usuario, Nulo)<BR>  Asigna(Info.Contrasena, Nulo)<BR>  Asigna(Info.ABC, Nulo)<BR>  Si<BR>    SQL(<T>SELECT ISNULL(SinAutorizarAperturaCajaMM,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>  Entonces<BR>    Forma(<T>POSMovAutorizarSup<T>)<BR>  Sino<BR>    Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>    EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>  Fin<BR>  SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1<BR>Sino<BR>Informacion(<T>LA CAJA YA ESTA ABIERTA... VERIFIQUE......<T> )<BR>Fin
VisibleCondicion=Pos.MultiMoneda
[Acciones.CorteParcialMM]
Nombre=CorteParcialMM
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Corte Parcial Caja Multimoneda<T>
TipoAccion=Expresion
Activo=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=30
BarraBtnImgAlto=30
NombreEnBotonX=S
edBotonSrc=F9.png
BarraBtnPagina=6
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F9
ConCondicion=S
Expresion=Asigna(Info.Mov, SQL(<T>SELECT CorteParcialCajaM FROM POSMovMenuSupervision WHERE Empresa = :tEmpresa<T>, Info.Empresa))<BR><BR>Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioMov WHERE Mov = :tMov AND Usuario = :tUsuario<T>, Info.Mov, Usuario) = 1<BR>Entonces<BR>  Asigna(Info.Mov, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CAMBIAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Mov, SQL(<T>SELECT CorteParcialCajaM FROM POSMovMenuSupervision WHERE Empresa = :tEmpresa<T>, Info.Empresa))<BR>  Asigna(Info.Mov, SQL(<T>SELECT m.Orden FROM POSUsuarioMov p JOIN MovTipo m ON p.Mov = m.Mov WHERE m.Modulo=:tm  AND p.Usuario =:tu AND p.Mov =:tMov<T>, <T>POS<T>, Usuario , Info.Mov))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Info.CtaDinero, SQL(<T>SELECT NULLIF(DefCtaDineroTrans, :tnulo) FROM Usuario WHERE Usuario =:tu<T>, <T> <T>,Usuario ))<BR>  Si<BR>    Info.CtaDinero = nulo<BR>  Entonces<BR>    Asigna(Temp.Numerico5,2)<BR>    Precaucion(<T>El Usuario no se tiene una Cuenta de Dinero configurada<T>)<BR>  Sino<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.CtaDinero, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>    Si<BR>      ConDatos(Info.Observaciones)<BR>    Entonces<BR>      Informacion( Info.Observaciones )<BR>    Sino<BR>      <T><T><BR>    Fin<BR><BR>    Forma(<T>PosMenuEspecialSupervicion<T>)<BR>  Fin<BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR>  Asigna(Info.IDTexto, SQL(<T>spPOSAbrir :tEmpresa, :tUsuario<T>, Empresa,Usuario))<BR>  EjecutarSQL(<T>spPOSInicializar  :tEmpresa, :nSucursal, :tUsuario, :nEstacion, :tID<T>,Empresa, Sucursal, Usuario, EstacionTrabajo, Info.IDTexto)<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen, Temp.Reg[11])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR><BR>  Forma.AsignarAnuncios(Ver.Imagen,Info.POSPublicidad ,5 )<BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR> Fin<BR>Sino<BR>  Informacion(<T>El usuario no tiene acceso al movimiento<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=Si<BR> SQL(<T>spPOSEstadoCaja :tID, :tUsuario<T>, Info.IDTexto, Usuario) = 1<BR>Entonces<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>  Asigna(Info.Usuario, Nulo)<BR>  Asigna(Info.Contrasena, Nulo)<BR>  Asigna(Info.ABC, Nulo)<BR>  Si<BR>    SQL(<T>SELECT ISNULL(SinAutorizarCorteParcialMM,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>  Entonces<BR>    Forma(<T>POSMovAutorizarSup<T>)<BR>  Sino<BR>    Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>    EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>  Fin<BR>  SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1<BR>Sino<BR>Informacion(<T>LA CAJA ESTA CERRADA... VERIFIQUE......<T> )<BR>Fin
VisibleCondicion=Pos.MultiMoneda
[Acciones.CorteCajaMM]
Nombre=CorteCajaMM
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Corte Caja Multimoneda<T>
TipoAccion=Expresion
Activo=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F10.png
BarraBtnPagina=6
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F10
ConCondicion=S
Expresion=Asigna(Info.Mov, SQL(<T>SELECT CorteCajaM FROM POSMovMenuSupervision WHERE Empresa = :tEmpresa<T>, Info.Empresa))<BR><BR>Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioMov WHERE Mov = :tMov AND Usuario = :tUsuario<T>, Info.Mov, Usuario) = 1<BR>Entonces<BR>  Asigna(Info.Mov, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CAMBIAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Mov, SQL(<T>SELECT CorteCajaM FROM POSMovMenuSupervision WHERE Empresa = :tEmpresa<T>, Info.Empresa))<BR>  Asigna(Info.Mov, SQL(<T>SELECT m.Orden FROM POSUsuarioMov p JOIN MovTipo m ON p.Mov = m.Mov WHERE m.Modulo=:tm  AND p.Usuario =:tu AND p.Mov =:tMov<T>, <T>POS<T>, Usuario , Info.Mov))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Info.CtaDinero, SQL(<T>SELECT NULLIF(DefCtaDineroTrans, :tnulo) FROM Usuario WHERE Usuario =:tu<T>, <T> <T>,Usuario ))<BR>  Si<BR>    Info.CtaDinero = nulo<BR>  Entonces<BR>    Asigna(Temp.Numerico5,2)<BR>    Precaucion(<T>El Usuario no se tiene una Cuenta de Dinero configurada<T>)<BR>  Sino<BR><BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.CtaDinero, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>    Asigna(Temp.TextoTemp01, SQL(<T>SELECT F8 FROM POSCobroFormasPago WHERE Empresa = :tEmpresa AND Sucursal = :tSucursal<T>, Info.Empresa, Sucursal))<BR>    Asigna(Temp.TextoTemp01, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND FormaPago = :tFormaPago<T>, <T>Forma Pago<T>, Temp.TextoTemp01))<BR><BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp01, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>   Si<BR>     ConDatos(Info.Observaciones)<BR>    Entonces<BR>      Informacion( Info.Observaciones )<BR>   Sino<BR>    <T><T><BR>   Fin<BR>  Forma(<T>PosMenuEspecialSupervicion<T>)<BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR>  Asigna(Info.IDTexto, SQL(<T>spPOSAbrir :tEmpresa, :tUsuario<T>, Empresa,Usuario))<BR>  EjecutarSQL(<T>spPOSInicializar  :tEmpresa, :nSucursal, :tUsuario, :nEstacion, :tID<T>,Empresa, Sucursal, Usuario, EstacionTrabajo, Info.IDTexto)<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen, Temp.Reg[11])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR><BR>  Forma.AsignarAnuncios(Ver.Imagen,Info.POSPublicidad ,5 )<BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR> Fin<BR>Sino<BR>  Informacion(<T>El usuario no tiene acceso al movimiento<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=Si<BR> SQL(<T>spPOSEstadoCaja :tID, :tUsuario<T>, Info.IDTexto, Usuario) = 1<BR>Entonces<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>  Asigna(Info.Usuario, Nulo)<BR>  Asigna(Info.Contrasena, Nulo)<BR>  Asigna(Info.ABC, Nulo)<BR>  Si<BR>    SQL(<T>SELECT ISNULL(SinAutorizarCorteCajaMM,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>  Entonces<BR>    Forma(<T>POSMovAutorizarSup<T>)<BR>  Sino<BR>    Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>    EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>  Fin<BR>  SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1<BR>Sino<BR>Informacion(<T>LA CAJA ESTA CERRADA... VERIFIQUE......<T> )<BR>Fin
VisibleCondicion=Pos.MultiMoneda
[Acciones.LogOferta]
Nombre=LogOferta
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Log de Ofertas<T>
TipoAccion=Reportes Pantalla
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F12.png
BarraBtnPagina=6
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado













TeclaFuncion=F12
ClaveAccion=OfertaLogPos



ActivoCondicion=SQL(<T>SELECT OfertaAplicaLogPos FROM EmpresaCFG2 WHERE Empresa = :tEmpresa<T>,Empresa)
[Acciones.Pesar]
Nombre=Pesar
Boton=0
NombreEnBoton=S
TeclaFuncion=F4
NombreDesplegar=<T>Pesar<T>
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
BarraBtnPagina=2
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado






























Expresion=Asigna(Pos.POSPesar,SQL(<T>SELECT ActivaBascula FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>Asigna(Pos.POSPuedePesar,SQL(<T>spPOSPuedePesar :tID<T>, Info.IDTexto))<BR>Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion2(:tID, :tAccion)<T>,Info.IDTexto, <T>PESAR<T>)<BR>Entonces<BR>  Si<BR>    Pos.POSPuedePesar<BR>  Entonces<BR>    Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>PESAR<T>))<BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR>    Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>    Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR>/*Se agrega las variables Pos.TextoSubtotal, Pos.TextoDescuento, Pos.TextoImpuestos para los totalizadores de POS.FRM JLMR Julio 2013*/<BR>    Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>    Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>    Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>    Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>    Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>    Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>    Asigna(Ver.Total, Temp.Reg[8])<BR>    Asigna(Info.Saldo, Temp.Reg[9])<BR>    Asigna(Info.Importe, Temp.Reg[9])<BR>    Asigna(Ver.Saldo, Temp.Reg[9])<BR>    Asigna(Ver.Imagen,Temp.Reg[11])<BR>    Asigna(Temp.TextoTemp02, nulo)<BR><BR>    Si <BR>      Ver.Aviso = <T>FAVOR DE INTRODUCIR EL PESO<T> y Pos.POSPesar<BR>    Entonces<BR>      FormaModal(<T>POSPesar<T>)<BR>      EscucharPuerto.EnviarMensaje(<T>LeerBascula<T>) Sino Asigna(Ver.Aviso, Ver.Aviso)<BR>    Fin<BR>  Sino<BR>    Informacion(<T>No Hay Nada Que Pesar<T>)<BR>  Fin<BR><BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.Separador4A]
Nombre=Separador4A
Boton=0
NombreDesplegar=<T>Separador4A<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=2





[Acciones.Separador5A]
Nombre=Separador5A
Boton=0
NombreDesplegar=<T>Separador5A<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=3





[Acciones.Separador6A]
Nombre=Separador6A
Boton=0
NombreDesplegar=<T>Separador6A<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=4





[Acciones.Separador8A]
Nombre=Separador8A
Boton=0
NombreDesplegar=<T>Separador8A<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=5





[Acciones.Separador8B]
Nombre=Separador8B
Boton=0
NombreDesplegar=<T>Separador8B<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=2
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=6


















[Acciones.AfectaMov.ListaAccionesMultiples]
(Inicio)=ValidarDetalle
ValidarDetalle=ValidarSerie
ValidarSerie=ValidaDevoluciones
ValidaDevoluciones=ValidaFacturasCredito
ValidaFacturasCredito=Afectar
Afectar=(Fin)




[Acciones.RecoleccionMM]
Nombre=RecoleccionMM
Boton=0
Activo=S
BarraBtnFondo=$00C08000
NombreDesplegar=<T>Recolección<T>
TeclaFuncion=F11
TipoAccion=Expresion
ConCondicion=S
BarraBtnAncho=75
BarraBtnAlto=75
BarraBtnPagina=6
BarraBtnMargen=2
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F11.png
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado



Expresion=Asigna(Info.Mov, SQL(<T>SELECT Recoleccion FROM POSMovMenuSupervision WHERE Empresa = :tEmpresa<T>, Info.Empresa))<BR><BR>Si<BR>  SQL(<T>SELECT 1 FROM POSUsuarioMov WHERE Mov = :tMov AND Usuario = :tUsuario<T>, Info.Mov, Usuario) = 1<BR>Entonces<BR>  Asigna(Info.Mov, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CAMBIAR MOVIMIENTO<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Mov, SQL(<T>SELECT Recoleccion FROM POSMovMenuSupervision WHERE Empresa = :tEmpresa<T>, Info.Empresa))<BR>  Asigna(Info.Mov, SQL(<T>SELECT m.Orden FROM POSUsuarioMov p JOIN MovTipo m ON p.Mov = m.Mov WHERE m.Modulo=:tm  AND p.Usuario =:tu AND p.Mov =:tMov<T>, <T>POS<T>, Usuario , Info.Mov))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Mov, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Info.CtaDinero, SQL(<T>SELECT NULLIF(DefCtaDineroTrans, :tnulo) FROM Usuario WHERE Usuario =:tu<T>, <T> <T>,Usuario ))<BR>  Si<BR>    Info.CtaDinero = nulo<BR>  Entonces<BR>    Asigna(Temp.Numerico5,2)<BR>    Precaucion(<T>El Usuario no se tiene una Cuenta de Dinero configurada<T>)<BR>  Sino<BR><BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.CtaDinero, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>    Asigna(Temp.TextoTemp01, SQL(<T>SELECT F8 FROM POSCobroFormasPago WHERE Empresa = :tEmpresa AND Sucursal = :tSucursal<T>, Info.Empresa, Sucursal))<BR>    Asigna(Temp.TextoTemp01, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND FormaPago = :tFormaPago<T>, <T>Forma Pago<T>, Temp.TextoTemp01))<BR><BR>    Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp01, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>    Asigna(Info.Observaciones, Temp.Reg[5])<BR><BR>   Si<BR>     ConDatos(Info.Observaciones)<BR>    Entonces<BR>      Informacion( Info.Observaciones )<BR>   Sino<BR>    <T><T><BR>   Fin<BR>  Forma(<T>PosMenuEspecialSupervicion<T>)<BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR>  Asigna(Info.IDTexto, SQL(<T>spPOSAbrir :tEmpresa, :tUsuario<T>, Empresa,Usuario))<BR>  EjecutarSQL(<T>spPOSInicializar  :tEmpresa, :nSucursal, :tUsuario, :nEstacion, :tID<T>,Empresa, Sucursal, Usuario, EstacionTrabajo, Info.IDTexto)<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Info.IDTexto, Temp.Reg[1])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen, Temp.Reg[11])<BR>  Asigna(Info.CtaCaja,Temp.Reg[18])<BR>  Asigna(Info.Grupo,Temp.Reg[19])<BR><BR>  Forma.AsignarAnuncios(Ver.Imagen,Info.POSPublicidad ,5 )<BR>  Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)<BR> Fin<BR>Sino<BR>  Informacion(<T>El usuario no tiene acceso al movimiento<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
EjecucionCondicion=Si<BR> SQL(<T>spPOSEstadoCaja :tID, :tUsuario<T>, Info.IDTexto, Usuario) = 1<BR>Entonces<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>  Asigna(Info.Usuario, Nulo)<BR>  Asigna(Info.Contrasena, Nulo)<BR>  Asigna(Info.ABC, Nulo)<BR>  Si<BR>    SQL(<T>SELECT ISNULL(SinAutorizarRecoleccionMM,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>  Entonces<BR>    Forma(<T>POSMovAutorizarSup<T>)<BR>  Sino<BR>    Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>    EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>  Fin<BR>  SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1<BR>Sino<BR>Informacion(<T>LA CAJA ESTA CERRADA... VERIFIQUE......<T> )<BR>Fin
VisibleCondicion=Pos.MultiMoneda

[Acciones.Enter.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar
Actualizar=(Fin)



















[Acciones.BtnCancelarPartida.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Vista
Actualizar Vista=Actualizar Forma
Actualizar Forma=(Fin)



[Acciones.CancelaPartida.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=ActualizarVista
ActualizarVista=ActualizarForma
ActualizarForma=(Fin)









[Acciones.CancelaPartida.A]
Nombre=A
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Informacion(<T>Hola<T>)













[Acciones.CancPartida.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion(:tID, :tAccion)<T>,Info.IDTexto, <T>CANCELAR PARTIDA<T>)<BR>Entonces<BR>  Si<BR>    Confirmacion( <T>¿Desea Eliminar Todo el Renglon?<T>, BotonSi, BotonNo ) = BotonSi<BR>  Entonces<BR>    EjecutarSQL(<T>spPOSCancelarPartida :tID, :nEliminaRenglon<T>, Info.IDTexto, 1)<BR>  Sino<BR>    EjecutarSQL(<T>spPOSCancelarPartida :tID, :nEliminaRenglon<T>, Info.IDTexto, 0)<BR>  Fin<BR>  Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CANCELAR PARTIDA<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.TextoTemp02, nulo)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)
[Acciones.CancPartida]
Nombre=CancPartida
Boton=0
NombreDesplegar=<T>Cancelar Partida<T>
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
edBotonSrc=F9.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado





ConCondicion=S








EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR>Asigna(Info.ABC, Nulo)<BR><BR>Si<BR>  SQL(<T>SELECT ISNULL(SinAutorizarCancelarPartida,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>Entonces<BR>  Forma(<T>POSMovAutorizarSup<T>)<BR>Sino<BR>  Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>Fin<BR><BR>SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1
[Acciones.CancPartida.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.CancPartida.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S


[Acciones.BtnCancPart]
Nombre=BtnCancPart
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+C
NombreDesplegar=<T>Cancelar Partida<T>
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=90
BarraBtnMargen=5
BarraBtnAlto=100
BarraBtnFondo=$004080FF
BarraBtnImgAncho=30
BarraBtnImgAlto=30
NombreEnBotonX=S
edBotonSrc=CancelarPartida.png
BarraBtnPagina=1
BarraBtnImgAlign=Derecha
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Izquierda

ListaAccionesMultiples=(Lista)
ConCondicion=S
EjecucionCondicion=EjecutarSQL(<T>EXEC spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto)<BR>Asigna(Info.Usuario, Nulo)<BR>Asigna(Info.Contrasena, Nulo)<BR>Asigna(Info.ABC, Nulo)<BR>Si<BR>  SQL(<T>SELECT ISNULL(SinAutorizarCancelarPartida,0) FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) = 0<BR>Entonces<BR>  Forma(<T>POSMovAutorizarSup<T>)<BR>Sino<BR>  Asigna( Info.ABC, SQL(<T>SELECT POSUsuarioAutoriza FROM POSCfg WHERE Empresa =:tEmpre<T>, Empresa) )<BR>  EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.ABC)<BR>Fin <BR>SQL(<T>SELECT 1 FROM POSL WHERE ID =:tID AND UsuarioAutoriza IS NOT NULL<T>, Info.IDTexto)= 1
[Acciones.BtnCancPart.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Si<BR>  SQL(<T>SELECT dbo.fnPOSUsuarioPerfilAccion(:tID, :tAccion)<T>,Info.IDTexto, <T>CANCELAR PARTIDA<T>)<BR>Entonces<BR>  Si<BR>    Confirmacion( <T>¿Desea Eliminar Todo el Renglon?<T>, BotonSi, BotonNo ) = BotonSi<BR>  Entonces<BR>    EjecutarSQL(<T>spPOSCancelarPartida :tID, :nEliminaRenglon<T>, Info.IDTexto, 1)<BR>  Sino<BR>    EjecutarSQL(<T>spPOSCancelarPartida :tID, :nEliminaRenglon<T>, Info.IDTexto, 0)<BR>  Fin<BR>  Asigna(Temp.TextoTemp02, SQL(<T>SELECT Codigo FROM CB WHERE TipoCuenta = :tTipoCuenta AND Accion = :tAccion<T>, <T>Accion<T>, <T>CANCELAR PARTIDA<T>))<BR>  Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Temp.TextoTemp02, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>  Asigna(Info.Observaciones, Temp.Reg[5])<BR>  Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>  Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR><BR><BR>  Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>  Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>  Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>  Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>  Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>  Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>  Asigna(Ver.Total, Temp.Reg[8])<BR>  Asigna(Info.Saldo, Temp.Reg[9])<BR>  Asigna(Info.Importe, Temp.Reg[9])<BR>  Asigna(Ver.Saldo, Temp.Reg[9])<BR>  Asigna(Ver.Imagen,Temp.Reg[11])<BR>  Asigna(Temp.TextoTemp02, nulo)<BR>Sino<BR>  Informacion(<T>El Usuario no tiene acceso a la acción<T>)<BR>Fin<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)


[Acciones.BtnCancPart.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.BtnCancPart.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S


[Acciones.POSOfertaTem]
Nombre=POSOfertaTem
Boton=0
TeclaFuncion=F7
NombreDesplegar=<T>Oferta Puntos<T>
TipoAccion=Expresion
BarraBtnFondo=$00C08000
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F7.png
BarraBtnPagina=3
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado
GuardarAntes=S
ConCondicion=S
EjecucionConError=S
Antes=S
DespuesGuardar=S









Expresion=Asigna(Info.POSMonedero, SQL(<T>SELECT Monedero FROM POSL WHERE ID = :tID<T>, Info.IDTexto))<BR>Asigna(Info.MonedaBase,SQL(<T>SELECT Moneda FROM POSValeSerie  WHERE Serie = :tMonedero<T>, Info.POSMonedero))<BR>FormaModal(<T>POSOfertaTemp<T>)<BR>Asigna(Temp.Reg,SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID, :nImporte, :tCodigoCambio, :nImporteCambio, :nCobro, :tLecturaTarjeta<T>,EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario,  Info.Referencia, Info.IDTexto, Nulo, Nulo, Nulo, 0, Nulo))<BR>/*La variable Info.Observaciones indica si el sp mando algun Mensaje de error*/<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR>Si ConDatos(Info.Observaciones)<BR>  Entonces Error( Info.Observaciones )<BR>  Sino <T><T><BR>Fin<BR><BR>/*La variable Info.PuedeEditar indica si Se recalculo todo el ticket (1) o solamente debe tomar la ultima linea (0)*/<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])
ActivoCondicion=General.OFER
EjecucionCondicion=Asigna(Info.Cerrado,SQL(<T>SELECT dbo.fnPOSEstatusCajaBloqueada(:tCaja)<T>,Info.CtaCaja))<BR>Asigna(Info.POSMonedero, SQL(<T>SELECT Monedero FROM POSL WHERE ID = :tID<T>, Info.IDTexto))<BR>(ConDatos(Info.POSMonedero))y(NO(Info.Cerrado))
EjecucionMensaje=Si(Info.Cerrado,<T>Caja Bloqueada<T>,<T>No Hay Ningun Monedero Asociado<T>)
AntesExpresiones=EjecutarSQL(<T>spPOSOfertaPuntosInsertarTemp :tID,:tFecha,:tPuntos,:nEstacion<T>,Info.IDTexto,Nulo,1,EstacionTrabajo)<BR>Asigna(Info.Clase3,SQL(<T>spPOSLDIValidarTarjeta :tServicio,:tId,:tMonedero,:tEmpresa,:tUsuario,:nSucursal,:nImporte,:nOk,:tOkref,:tOkLDI,:nMostrar<T>,<T>MON CONSULTA<T>,Info.IDTexto,Info.POSMonedero,Empresa,Usuario,Sucursal,Nulo,Nulo,Nulo,Nulo,1))<BR>Si EsNumerico(Info.Clase3)<BR>Entonces<BR>  Asigna(Info.Disponible,Info.Clase3)<BR>SiNo<BR>  Asigna(Info.Clase3,Nulo)<BR>Fin
VisibleCondicion=Temp.POSMonederoL










































[Acciones.CancPartida.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Vista
Actualizar Vista=Actualizar Forma
Actualizar Forma=(Fin)





[Acciones.EliminaCaptura.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=ValidaDevolucion
ValidaDevolucion=ActualizarVista
ActualizarVista=ActualizarForma
ActualizarForma=(Fin)
















[POSLVentaDev.POSLVenta.Articulo]
Carpeta=POSLVentaDev
Clave=POSLVenta.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSLVentaDev.POSLVenta.SubCuenta]
Carpeta=POSLVentaDev
Clave=POSLVenta.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco






















[POSLVentaDev.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=OpcionDesc
OpcionDesc=POSLVenta.Almacen
POSLVenta.Almacen=Art.Tipo
Art.Tipo=(Fin)














[POSLVentaDev.ListaEnCaptura]
(Inicio)=POSLVenta.Articulo
POSLVenta.Articulo=POSLVenta.SubCuenta
POSLVenta.SubCuenta=(Fin)










[POSLVenta.POSLVenta.Articulo]
Carpeta=POSLVenta
Clave=POSLVenta.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco

[POSLVenta.POSLVenta.SubCuenta]
Carpeta=POSLVenta
Clave=POSLVenta.SubCuenta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





[POSLVenta.Columnas]
Articulo=124
SubCuenta=83














Cantidad=64
CantidadM=100
Unidad=85
Precio=97
PrecioConImp=108
DescuentoLinea=92
DescuentoAd=82
Agente=64
[Codigo.ListaAccionesBB]
(Inicio)=btnBuscarArticulo
btnBuscarArticulo=BtnInventario
BtnInventario=(Fin)






[POSLVenta.POSLVenta.Cantidad]
Carpeta=POSLVenta
Clave=POSLVenta.Cantidad
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSLVenta.POSLVenta.CantidadM]
Carpeta=POSLVenta
Clave=POSLVenta.CantidadM
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EditarConBloqueo=S
[POSLVenta.POSLVenta.Unidad]
Carpeta=POSLVenta
Clave=POSLVenta.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[POSLVenta.POSLVenta.Precio]
Carpeta=POSLVenta
Clave=POSLVenta.Precio
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco














[POSLVenta.PrecioConImp]
Carpeta=POSLVenta
Clave=PrecioConImp
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSLVenta.POSLVenta.DescuentoLinea]
Carpeta=POSLVenta
Clave=POSLVenta.DescuentoLinea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSLVenta.POSLVenta.DescuentoAd]
Carpeta=POSLVenta
Clave=POSLVenta.DescuentoAd
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSLVenta.POSLVenta.Almacen]
Carpeta=POSLVenta
Clave=POSLVenta.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[POSLVenta.POSLVenta.Agente]
Carpeta=POSLVenta
Clave=POSLVenta.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


























[Acciones.Separador]
Nombre=Separador
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=5
BarraBtnAlto=75
BarraBtnFondo=Plata
BarraBtnPagina=1

[Acciones.Guardar.Expresiones]
Nombre=Expresiones
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>spPOSInsertaDevolucionP :@ID, :@Mov<T>, POSLVenta:POSLVenta.ID, <T>Nota<T>)<BR>EjecutarSQL(<T>spPOSArtPrecioRecalcular :@ID, :@Estacion<T>, POSLVenta:POSLVenta.ID,  EstacionTrabajo)<BR>Asigna(Info.Numero, 1)<BR>ActualizarVista<BR>ActualizarForma
[Acciones.Guardar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=//Esto es lo que estaba en la forma de POSLVentaDev en la accion Al Cerrar<BR>EjecutarSQL(<T>spPOSInicializar  :tEmpresa, :nSucursal, :tUsuario, :nEstacion, :tID<T>,Empresa, Sucursal, Usuario, EstacionTrabajo, Info.IDTexto)<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>Asigna(Pos.TextoSubtotal, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 1))<BR>Asigna(Pos.TextoDescuento, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 2))<BR>Asigna(Pos.TextoImpuestos, SQL(<T>spPOSTotales :tFiltro, :nPosicion<T>, Temp.Reg[3], 3))<BR><BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen, Temp.Reg[11])<BR>Asigna(Info.CtaCaja,Temp.Reg[18])<BR>Asigna(Info.Grupo,Temp.Reg[19])<BR><BR>Forma.AsignarAnuncios(Ver.Imagen,Info.POSPublicidad ,5 )<BR>Forma.EnfocarVariable(<T>Codigo<T>,<T>Info.Codigo<T>)  <BR><BR>//Esto es para que se vaya a la Carpeta por default <BR>si (SQL(<T>SELECT PanelAMostrar FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<><T>Imágenes<T><BR>entonces<BR>Forma.IrCarpeta(<T>btnCategoria<T>)<BR>sino<BR>Forma.IrCarpeta(<T>Imagen<T>)<BR>fin
[Acciones.Guardar]
Nombre=Guardar
Boton=0
NombreDesplegar=<T>Aceptar<T>
GuardarAntes=S
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnFondo=$00C08000


Antes=S
DespuesGuardar=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=Seleccionar.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado



























AntesExpresiones=EjecutarSQL( <T>spPOSUsuarioDesautoriza :tID<T>, Info.IDTexto )
[Acciones.POSLSerieLote]
Nombre=POSLSerieLote
Boton=0
NombreDesplegar=<T>Serie/Lotes<T>
GuardarAntes=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=POSLSerieLoteTemp
Antes=S
DespuesGuardar=S
Visible=S
BarraBtnFondo=$00C08000
ActivoCondicion=POSLVenta:Art.Tipo en (TipoSerie, TipoVIN, TipoLote)
AntesExpresiones=Asigna(Info.Articulo,POSLVenta:POSLVenta.Articulo)<BR>Asigna(Info.IDTexto,POSLVenta:POSLVenta.ID)<BR>Asigna(Info.SubCuenta,POSLVenta:POSLVenta.SubCuenta)<BR>Asigna(Info.Cantidad,POSLVenta:POSLVenta.Cantidad)<BR>Asigna(Info.ArtTipo,POSLVenta:Art.Tipo)<BR>Asigna(Info.RenglonID,POSLVenta:POSLVenta.RenglonID)<BR><BR>EjecutarSQL(<T>spPOSInsertarPOSLSerieLoteTemp :nEstacion,:tID,:nRenglonID<T>,EstacionTrabajo,POSLVenta:POSLVenta.ID,POSLVenta:POSLVenta.RenglonID)
BarraBtnAncho=75
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











[BtnCategoria.ListaAccionesBB]
(Inicio)=CatInicio
CatInicio=CatRetroceder
CatRetroceder=CatAvanzar
CatAvanzar=(Fin)

[BtnArticulo.ListaAccionesBB]
(Inicio)=ArtCatRegresar
ArtCatRegresar=ArtInicio
ArtInicio=ArtRegresar
ArtRegresar=ArtAvanzar
ArtAvanzar=(Fin)




[Acciones.BtnEliminarCaptura.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Validadevolucion
Validadevolucion=Actualizar Vista
Actualizar Vista=Actualizar Forma
Actualizar Forma=(Fin)



[Acciones.BtnCancPart.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Vista
Actualizar Vista=Actualizar Forma
Actualizar Forma=(Fin)













[Acciones.BtnEncabezado.ListaAccionesMultiples]
(Inicio)=Forma
Forma=Expresion
Expresion=(Fin)



































[Acciones.Guardar.ListaAccionesMultiples]
(Inicio)=Expresiones
Expresiones=Aceptar
Aceptar=(Fin)

[POSLVenta.ListaEnCaptura]
(Inicio)=POSLVenta.Articulo
POSLVenta.Articulo=POSLVenta.SubCuenta
POSLVenta.SubCuenta=POSLVenta.Cantidad
POSLVenta.Cantidad=POSLVenta.CantidadM
POSLVenta.CantidadM=POSLVenta.Unidad
POSLVenta.Unidad=POSLVenta.Precio
POSLVenta.Precio=PrecioConImp
PrecioConImp=POSLVenta.DescuentoLinea
POSLVenta.DescuentoLinea=POSLVenta.DescuentoAd
POSLVenta.DescuentoAd=POSLVenta.Almacen
POSLVenta.Almacen=POSLVenta.Agente
POSLVenta.Agente=(Fin)

[POSLVenta.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=OpcionDesc
OpcionDesc=POSLVenta.Almacen
POSLVenta.Almacen=Art.Tipo
Art.Tipo=(Fin)

[POSLVenta.ListaAccionesBB]
(Inicio)=Separador
Separador=Guardar
Guardar=POSLSerieLote
POSLSerieLote=(Fin)






[Ticket.ListaAccionesBB]
(Inicio)=BtnNuevo
BtnNuevo=BtnEncabezado
BtnEncabezado=BtnDetalle
BtnDetalle=BtnVerificarPrecios
BtnVerificarPrecios=BtnReferenciaOrigen
BtnReferenciaOrigen=BtnDatosVuelo
BtnDatosVuelo=BtnModificarAgente
BtnModificarAgente=BtnEliminarCaptura
BtnEliminarCaptura=BtnModificarCantidad
BtnModificarCantidad=BtnCancPart
BtnCancPart=(Fin)

















[Saldo.ListaEnCaptura]
(Inicio)=Pos.TextoSubtotal
Pos.TextoSubtotal=Pos.TextoDescuento
Pos.TextoDescuento=Pos.TextoImpuestos
Pos.TextoImpuestos=Ver.Total
Ver.Total=(Fin)

[Saldo.ListaAccionesBB]
(Inicio)=Separador3
Separador3=MenuPrincipal
MenuPrincipal=MenuEdicion
MenuEdicion=MenuMovimientos
MenuMovimientos=MenuClientes
MenuClientes=Separador1
Separador1=MenuSupervisor
MenuSupervisor=EliminaCaptura
EliminaCaptura=ModificaCantidad
ModificaCantidad=BuscaArticulo
BuscaArticulo=Separador2
Separador2=CancPartida
CancPartida=BloqueaDesbloquea
BloqueaDesbloquea=SalirPOS
SalirPOS=AfectaMov
AfectaMov=RegresarP2
RegresarP2=Separador4
Separador4=NavegarMov
NavegarMov=ListaMov
ListaMov=ReversaPago
ReversaPago=Pesar
Pesar=Separador4A
Separador4A=AltaMonedero
AltaMonedero=ConsultaInvenatario
ConsultaInvenatario=RegresarP3
RegresarP3=Separador5A
Separador5A=MovNuevo
MovNuevo=EditarEncabezado
EditarEncabezado=EditarDetalle
EditarDetalle=VerificaPrecio
VerificaPrecio=Separador5
Separador5=RefOrigen
RefOrigen=ModificaAgente
ModificaAgente=POSOfertaTem
POSOfertaTem=RegresarP4
RegresarP4=Separador6A
Separador6A=UsuarioAutoriza
UsuarioAutoriza=MovNota
MovNota=MovFacturaCredito
MovFacturaCredito=MovCobroCred
MovCobroCred=Separador6
Separador6=MovPedido
MovPedido=MovDevolucion
MovDevolucion=MovDevParcial
MovDevParcial=MovFormaEnvio
MovFormaEnvio=Separador7
Separador7=LlamaPedido
LlamaPedido=LlamaAnticipo
LlamaAnticipo=MovPendiente
MovPendiente=MovNotaxCobrar
MovNotaxCobrar=RegresarP5
RegresarP5=Separador8A
Separador8A=ModDatosCte
ModDatosCte=AgregaCliente
AgregaCliente=BuscaCliente
BuscaCliente=ClienteInfo
ClienteInfo=RegresarP6
RegresarP6=Separador8B
Separador8B=VerValores
VerValores=AperturaCaja
AperturaCaja=AumentoCaja
AumentoCaja=CorteParcial
CorteParcial=Separador8
Separador8=CorteCaja
CorteCaja=Egreso
Egreso=Ingreso
Ingreso=AperturaCajaMM
AperturaCajaMM=CorteParcialMM
CorteParcialMM=CorteCajaMM
CorteCajaMM=RecoleccionMM
RecoleccionMM=LogOferta
LogOferta=(Fin)

[Forma.ListaCarpetas]
(Inicio)=Codigo
Codigo=Aviso
Aviso=Ticket
Ticket=BtnCategoria
BtnCategoria=BtnArticulo
BtnArticulo=Imagen
Imagen=Saldo
Saldo=(Fin)

[Forma.ListaAcciones]
(Inicio)=Eliminar
Eliminar=Cantidad
Cantidad=BuscarArticulo
BuscarArticulo=CancelarPartida
CancelarPartida=Bloquear
Bloquear=Salir
Salir=Afectar
Afectar=Enter
Enter=POSMonedero
POSMonedero=CancelarOfertas
CancelarOfertas=POSCobroCondicionTemp
POSCobroCondicionTemp=EliminarMov
EliminarMov=Regresar
Regresar=POSUsuario2
POSUsuario2=(Fin)
