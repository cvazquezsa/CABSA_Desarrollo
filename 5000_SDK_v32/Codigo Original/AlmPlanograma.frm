
[Forma]
Clave=AlmPlanograma
Icono=0
Modulos=(Todos)
Nombre=Almacen

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=576
PosicionInicialArriba=349
PosicionInicialAlturaCliente=351
PosicionInicialAncho=754
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AlmPlanograma
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Almacén<T>
CampoColorLetras=Negro
CampoColorFondo=Blanco

ListaOrden=Almacen<TAB>(Acendente)
FiltroPredefinido=S
FiltroGrupo1=AlmPos.Zona
FiltroValida1=AlmPos.Zona
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroTodoNombre=(Todo)
FiltroTodoFinal=S
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Arbol
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S



FuenteBusqueda={MS Sans Serif, 8, Negro, []}
PestanaOtroNombre=S
PestanaNombre=Almacenes




ListaEnCaptura=(Lista)
FiltroArbolClave=Almacen
FiltroArbolValidar=Nombre
FiltroArbolRama=Rama
FiltroEnOrden=S
FiltroSucursales=S
PermiteLocalizar=S
FiltroArbolAcumulativas=Alm.Tipo
FiltroArbolTipoEstructura=S
IconosNombre=AlmPlanograma:Almacen
[Lista.Columnas]
0=164
1=268
2=-2
3=64
4=-2




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













[Lista.ListaOrden]
(Inicio)=AlmPos.Orden	(Acendente)
AlmPos.Orden	(Acendente)=AlmPos.Posicion	(Acendente)
AlmPos.Posicion	(Acendente)=(Fin)








[Lista.ListaEnCaptura]
(Inicio)=Nombre
Nombre=Grupo
Grupo=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)

[Lista.Nombre]
Carpeta=Lista
Clave=Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Grupo]
Carpeta=Lista
Clave=Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





























[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Personalizar
Personalizar=(Fin)
