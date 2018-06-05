
[Forma]
Clave=MFALayoutDocumentoLista
Icono=0
CarpetaPrincipal=Lista
Modulos=(Todos)
Nombre=<T>MFA - Lista Documentos<T>

ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=390
PosicionInicialArriba=145
PosicionInicialAlturaCliente=421
PosicionInicialAncho=500
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFALayoutDocumentoLista
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Folio<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

BusquedaRapidaControles=S
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
FiltroAutoCampo=MFALayoutDocumentoLista.empresa
FiltroAutoValidar=MFALayoutDocumentoLista.empresa
IconosNombre=MFALayoutDocumentoLista:MFALayoutDocumentoLista.folio
[Lista.MFALayoutDocumentoLista.fecha]
Carpeta=Lista
Clave=MFALayoutDocumentoLista.fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.MFALayoutDocumentoLista.emisor]
Carpeta=Lista
Clave=MFALayoutDocumentoLista.emisor
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


[Lista.Columnas]
0=-2
1=88
2=-2
3=-2











[Lista.ListaEnCaptura]
(Inicio)=MFALayoutDocumentoLista.fecha
MFALayoutDocumentoLista.fecha=MFALayoutDocumentoLista.emisor
MFALayoutDocumentoLista.emisor=(Fin)
