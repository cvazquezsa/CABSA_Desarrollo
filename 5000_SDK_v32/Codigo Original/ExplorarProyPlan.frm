[Forma]
Clave=ExplorarProyPlan
Nombre=Explorar Plantilla
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=173
PosicionInicialArriba=165
PosicionInicialAlturaCliente=403
PosicionInicialAncho=677
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
Comentarios=Info.ProyPlan
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyPlanTarea
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroArbolClave=ProyPlanTarea.Clave
FiltroArbolRama=ProyPlanTarea.Rama
FiltroArbolAcumulativas=ProyPlanTarea.TieneDetalle
FiltroNullNombre=(sin clasificar)
FiltroTodoNombre=Tareas
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Arbol
CarpetaVisible=S
FiltroArbolValidar=ProyPlanTarea.Asunto
FiltroTodo=S
FiltroArbolOrden=ProyPlanTarea.Orden
OtroOrden=S
ListaOrden=(Lista)
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
IconosSubTitulo=<T>Asunto<T>
PestanaOtroNombre=S
PestanaNombre=Tareas
IconosNombre=ProyPlanTarea:ProyPlanTarea.Asunto
FiltroGeneral=ProyPlanTarea.Plantilla=<T>{Info.ProyPlan}<T>

[Lista.ProyPlanTarea.Tiempo]
Carpeta=Lista
Clave=ProyPlanTarea.Tiempo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyPlanTarea.TiempoUnidad]
Carpeta=Lista
Clave=ProyPlanTarea.TiempoUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=406
1=48
Tiempo=39
TiempoUnidad=42
Asunto=446

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=ProyPlanTarea.Tiempo
ProyPlanTarea.Tiempo=ProyPlanTarea.TiempoUnidad
ProyPlanTarea.TiempoUnidad=(Fin)

[Lista.ListaOrden]
(Inicio)=ProyPlanTarea.Orden<TAB>(Acendente)
ProyPlanTarea.Orden<TAB>(Acendente)=ProyPlanTarea.Asunto<TAB>(Acendente)
ProyPlanTarea.Asunto<TAB>(Acendente)=(Fin)
