
[Forma]
Clave=TipoComprobanteLista
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Tipos de Comprobantes
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=337
PosicionInicialAncho=480
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=480
PosicionInicialArriba=268
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoComprobante
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TipoComprobante.VigenciaD
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
CarpetaVisible=S


IconosNombreNumerico=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=TipoComprobante:TipoComprobante.TipoComprobante
FiltroGeneral=TipoComprobante.VigenciaD <= {Comillas(FechaFormatoServidor(Hoy))}
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

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Lista.Columnas]
0=48
1=331





2=89

[Lista.TipoComprobante.VigenciaD]
Carpeta=Lista
Clave=TipoComprobante.VigenciaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.ListaEnCaptura]
(Inicio)=TipoComprobante.TipoComprobante
TipoComprobante.TipoComprobante=TipoComprobante.VigenciaD
TipoComprobante.VigenciaD=(Fin)













[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Personalizar
Personalizar=(Fin)
