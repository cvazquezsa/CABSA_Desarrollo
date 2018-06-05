[Forma]
Clave=CampanaTipoSituacionTarea
Nombre=Tareas por Omisión de la Situación
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Tipo, Info.Situacion)
PosicionInicialIzquierda=588
PosicionInicialArriba=342
PosicionInicialAlturaCliente=479
PosicionInicialAncho=710

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CampanaTipoSituacionTarea
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=CampanaTipoSituacionTarea.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
HojaTitulos=S
HojaMostrarColumnas=S
FiltroGeneral=CampanaTipoSituacionTarea.CampanaTipo=<T>{Info.Tipo}<T> AND<BR>CampanaTipoSituacionTarea.Situacion=<T>{Info.Situacion}<T>

[Lista.CampanaTipoSituacionTarea.Tarea]
Carpeta=Lista
Clave=CampanaTipoSituacionTarea.Tarea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
Tarea=604
Orden=36
Dias=31

[Lista.CampanaTipoSituacionTarea.Orden]
Carpeta=Lista
Clave=CampanaTipoSituacionTarea.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CampanaTipoSituacionTarea.Dias]
Carpeta=Lista
Clave=CampanaTipoSituacionTarea.Dias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=CampanaTipoSituacionTarea.Tarea
CampanaTipoSituacionTarea.Tarea=CampanaTipoSituacionTarea.Dias
CampanaTipoSituacionTarea.Dias=CampanaTipoSituacionTarea.Orden
CampanaTipoSituacionTarea.Orden=(Fin)
