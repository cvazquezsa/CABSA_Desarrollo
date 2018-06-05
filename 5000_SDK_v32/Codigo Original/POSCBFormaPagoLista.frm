
[Forma]
Clave=POSCBFormaPagoLista
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=POS Formas de Pago
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=POSCBFormaPago
CarpetaPrincipal=POSCBFormaPago
PosicionInicialAlturaCliente=264
PosicionInicialAncho=315
ListaAcciones=Seleccionar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=642
PosicionInicialArriba=299
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
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral=POSCBFormaPago.TipoCuenta = <T>Forma Pago<T>
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
Codigo=100
Accion=154


FormaPago=172

[POSCBFormaPago.POSCBFormaPago.FormaPago]
Carpeta=POSCBFormaPago
Clave=POSCBFormaPago.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco








[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[POSCBFormaPago.ListaEnCaptura]
(Inicio)=POSCBFormaPago.Codigo
POSCBFormaPago.Codigo=POSCBFormaPago.FormaPago
POSCBFormaPago.FormaPago=(Fin)
