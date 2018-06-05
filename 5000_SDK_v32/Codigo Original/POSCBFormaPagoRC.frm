
[Forma]
Clave=POSCBFormaPagoRC
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=POS Formas de Pago
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=POSCBFormaPago
CarpetaPrincipal=POSCBFormaPago
PosicionInicialAlturaCliente=360
PosicionInicialAncho=313
ListaAcciones=Seleccionar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=526
PosicionInicialArriba=164
VentanaBloquearAjuste=S
VentanaExclusivaOpcion=0
[POSCBFormaPago]
Estilo=Hoja
Clave=POSCBFormaPago
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCBFormaPago
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
ListaEnCaptura=POSCBFormaPago.Codigo

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

BusquedaRapidaControles=S
FiltroGeneral=POSCBFormaPago.TipoCuenta = <T>Forma Pago<T>
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
[POSCBFormaPago.POSCBFormaPago.Codigo]
Carpeta=POSCBFormaPago
Clave=POSCBFormaPago.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


[POSCBFormaPago.Columnas]
Codigo=274
Accion=154


FormaPago=172


[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

Multiple=S
ListaAccionesMultiples=(Lista)

[Forma.ListaAcciones]
(Inicio)=Expresion
Expresion=Seleccionar
Seleccionar=(Fin)

[Acciones.Seleccionar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.FormaPago,POSCBFormaPago:POSCBFormaPago.Codigo)<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.FormaPago, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR>Asigna(Info.Observaciones, Temp.Reg[5])<BR>Asigna(Info.PuedeEditar, Temp.Reg[4])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen,Temp.Reg[11])<BR>Asigna(Info.FormaPago, nulo)
Activo=S
Visible=S

[Acciones.Seleccionar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Seleccionar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cerrar
Cerrar=(Fin)

[POSCBFormaPago.ListaEnCaptura]
(Inicio)=POSCBFormaPago.Codigo
POSCBFormaPago.Codigo=POSCBFormaPago.FormaPago
POSCBFormaPago.FormaPago=(Fin)
