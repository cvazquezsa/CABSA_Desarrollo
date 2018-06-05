
[Forma]
Clave=TMAPendiente
Icono=17
Modulos=(All)
Nombre=Tarimas Pendientes

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=492
PosicionInicialAncho=664
EsConsultaExclusiva=S
SinCondicionDespliege=S
PosicionInicialIzquierda=555
PosicionInicialArriba=337
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Mov, Info.MovID)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
VentanaExclusiva=S
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TMAT
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Tarima<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

ListaEnCaptura=(Lista)


PestanaOtroNombre=S
PestanaNombre=Tarimas
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
IconosSeleccionMultiple=S
MenuLocal=S
IconosNombre=TMAT:TMAD.Tarima
FiltroGeneral=TMA.Estatus=<T>PENDIENTE<T> AND TMAD.EstaPendiente=1 AND MovTipo.Clave=<T>{Info.MovTipo}<T>
ListaAcciones=(Lista)
[Lista.MovNombre]
Carpeta=Lista
Clave=MovNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TMAD.Almacen]
Carpeta=Lista
Clave=TMAD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TMAD.Posicion]
Carpeta=Lista
Clave=TMAD.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TMAD.PosicionDestino]
Carpeta=Lista
Clave=TMAD.PosicionDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=118
1=179
2=78
3=-2
4=90




[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

Antes=S
AntesExpresiones=RegistrarSeleccionIDRenglon(<T>Lista<T>, <T>TMA<T>, <T>TMAD.ID<T>, <T>TMAD.Renglon<T>, <T><T>)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
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
















[Acciones.LocalTodo]
Nombre=LocalTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.LocalQuitar]
Nombre=LocalQuitar
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=MovNombre
MovNombre=TMAD.Almacen
TMAD.Almacen=TMAD.Posicion
TMAD.Posicion=TMAD.PosicionDestino
TMAD.PosicionDestino=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=(Fin)












[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=55
NombreEnBoton=S
NombreDesplegar=Seleccionar &Todo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S













[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Seleccionar Todo
Seleccionar Todo=Personalizar
Personalizar=(Fin)
