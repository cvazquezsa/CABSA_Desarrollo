[Forma]
Clave=ProyPlanTarea
Nombre=<T>Tareas - <T>+Info.Asunto
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=1368
PosicionInicialArriba=119
PosicionInicialAlturaCliente=352
PosicionInicialAncho=722
Comentarios=Info.ProyPlan
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=por Omisión
VentanaRepetir=S
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyPlanTarea
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
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
OtroOrden=S
ListaOrden=(Lista)
HojaMantenerSeleccion=S
FiltroGeneral=ProyPlanTarea.Plantilla=<T>{Info.ProyPlan}<T> <BR>AND ProyPlanTarea.Rama {Si(Info.Clave=<T>(Inicio)<T>, <T>IS NULL<T>, <T>=<T>+Comillas(Info.Clave))}

[Lista.ProyPlanTarea.Asunto]
Carpeta=Lista
Clave=ProyPlanTarea.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyPlanTarea.Orden]
Carpeta=Lista
Clave=ProyPlanTarea.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Asunto=533
Orden=36
Tiempo=41
TiempoUnidad=40
TieneDetalle=39
Duracion=46
DuracionUnidad=39

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.ProyPlanTarea.TieneDetalle]
Carpeta=Lista
Clave=ProyPlanTarea.TieneDetalle
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyPlanTarea.Tiempo]
Carpeta=Lista
Clave=ProyPlanTarea.Tiempo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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

[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalle
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
Expresion=EjecutarSQL(<T>spListaStAgregar :nEstacion, :tClave<T>, EstacionTrabajo, Info.Clave) <BR>Asigna(Info.Asunto, ProyPlanTarea:ProyPlanTarea.Asunto)<BR>Asigna(Info.Clave, ProyPlanTarea:ProyPlanTarea.Clave)<BR>Forma(<T>ProyPlanTarea<T>)<BR>Asigna(Info.Clave, SQL(<T>spListaStQuitar :nEstacion<T>, EstacionTrabajo))
ActivoCondicion=ProyPlanTarea:ProyPlanTarea.TieneDetalle

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Detalle
Detalle=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ProyPlanTarea.Asunto
ProyPlanTarea.Asunto=ProyPlanTarea.Orden
ProyPlanTarea.Orden=ProyPlanTarea.TieneDetalle
ProyPlanTarea.TieneDetalle=ProyPlanTarea.Tiempo
ProyPlanTarea.Tiempo=ProyPlanTarea.TiempoUnidad
ProyPlanTarea.TiempoUnidad=(Fin)

[Lista.ListaOrden]
(Inicio)=ProyPlanTarea.Orden<TAB>(Acendente)
ProyPlanTarea.Orden<TAB>(Acendente)=ProyPlanTarea.Asunto<TAB>(Acendente)
ProyPlanTarea.Asunto<TAB>(Acendente)=(Fin)
