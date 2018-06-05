[Forma]
Clave=ProyectoDAsignar
Nombre=Asignar Actividades
Icono=29
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=352
PosicionInicialArriba=135
PosicionInicialAlturaCliente=459
PosicionInicialAncho=836
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Proyecto, Info.Recurso, Info.Nombre, <T>Actividades sin Asignar<T>)
VentanaExclusiva=S
EsConsultaExclusiva=S

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
ExpresionesAlMostrar=Asigna(Ver.Todo, Verdadero)
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Actividades
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyectoD
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Actividad<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
OtroOrden=S
ListaOrden=ProyectoD.Orden<TAB>(Acendente)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosSeleccionMultiple=S
MenuLocal=S
ListaAcciones=(Lista)

IconosNombre=ProyectoD:ProyectoD.Actividad
FiltroGeneral=ProyectoD.ID={Info.ID} AND ProyectoD.Estado NOT IN (<T>Completada<T>, <T>Cancelada<T>, <T>Eliminada<T>) AND<BR>ProyectoD.IDGestion IS NULL AND<BR>{Si(ConDatos(Info.Aplica), <T>CASE WHEN LEN(Orden) = 5 THEN Orden ELSE LEFT(Orden, 5) END =<T>+Comillas(Info.Aplica),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoEstado), <T>ProyectoD.Estado=<T>+Comillas(Info.ProyectoEstado),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoRecurso), <T>ProyectoD.RecursosAsignados=<T>+Comillas(Info.ProyectoRecurso),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoAvanceD), <T>ISNULL(ProyectoD.Avance,0)>=<T>+Comillas(Info.ProyectoAvanceD),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoAvanceA), <T>ISNULL(ProyectoD.Avance,0)<=<T>+Comillas(Info.ProyectoAvanceA),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoFechaInicioD), <T>ProyectoD.Comienzo>=<T>+Comillas(FechaFormatoServidor(Info.ProyectoFechaInicioD)),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoFechaInicioA), <T>ProyectoD.Comienzo<=<T>+Comillas(FechaFormatoServidor(Info.ProyectoFechaInicioA)),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoFechaConclusionD), <T>ProyectoD.Fin>=<T>+Comillas(FechaFormatoServidor(Info.ProyectoFechaConclusionD)),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoFechaConclusionA), <T>ProyectoD.Fin<=<T>+Comillas(FechaFormatoServidor(Info.ProyectoFechaConclusionA)),<T>1=1<T>)}
[Lista.Columnas]
0=84
1=209

2=51
3=70
4=110
5=263
[Acciones.Cancelar]
Nombre=Cancelar
Boton=23
NombreEnBoton=S
NombreDesplegar=<T>&Cerrar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=&Personalizar Vista
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


[Acciones.Asignar]
Nombre=Asignar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Asignar Selección
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S

Expresion=Si<BR>  Forma(<T>EspecificarRecursoProyecto<T>)<BR>Entonces<BR>  RegistrarSeleccion(<T>Lista<T>)<BR>  EjecutarSQL(<T>spProyectoDAsignar :nID, :nEstacion, :tRecurso, @DesAsignar = 1<T>, Info.ID, EstacionTrabajo, Info.ProyRecurso)<BR>  Forma.ActualizarForma<BR>Fin
[Lista.ProyectoD.Asunto]
Carpeta=Lista
Clave=ProyectoD.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.ProyectoD.Tipo]
Carpeta=Lista
Clave=ProyectoD.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ProyectoD.RecursosAsignados]
Carpeta=Lista
Clave=ProyectoD.RecursosAsignados
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco


[Lista.ProyectoD.Estado]
Carpeta=Lista
Clave=ProyectoD.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco







[Acciones.Filtros]
Nombre=Filtros
Boton=107
NombreDesplegar=Aplicar &Filtros
RefrescarDespues=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S







Expresion=Si(Forma(<T>ProyectoFiltros<T>), ActualizarVista)











[Lista.ProyectoD.Avance]
Carpeta=Lista
Clave=ProyectoD.Avance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
























[Lista.ListaEnCaptura]
(Inicio)=ProyectoD.Asunto
ProyectoD.Asunto=ProyectoD.Tipo
ProyectoD.Tipo=ProyectoD.Avance
ProyectoD.Avance=ProyectoD.Estado
ProyectoD.Estado=ProyectoD.RecursosAsignados
ProyectoD.RecursosAsignados=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=(Fin)










[Acciones.Gestion]
Nombre=Gestion
Boton=29
NombreEnBoton=S
NombreDesplegar=&Enviar a Gestión
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S



EspacioPrevio=S












































Expresion=RegistrarSeleccion(<T>Lista<T>)<BR>EjecutarSQL(<T>spProyectoGestionGenerarLote :nEstacion, :nID<T>, EstacionTrabajo, Info.ID)<BR>Forma.ActualizarForma
VisibleCondicion=Config.ProyEnviarTareaGestion y (Info.Estatus en (EstatusPendiente))





[Acciones.Desasignar]
Nombre=Desasignar
Boton=40
NombreEnBoton=S
NombreDesplegar=&Desasignar Selección
EnBarraHerramientas=S
EspacioPrevio=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
TipoAccion=Expresion
Expresion=RegistrarSeleccion(<T>Lista<T>)<BR>EjecutarSQL(<T>spProyectoDAsignar :nID, :nEstacion, :tRecurso, :tAccion<T>, Info.ID, EstacionTrabajo, Info.Recurso, <T>DESASIGNAR<T>)<BR>Forma.ActualizarForma
Activo=S
Visible=S



[Forma.ListaAcciones]
(Inicio)=Cancelar
Cancelar=Asignar
Asignar=Desasignar
Desasignar=Gestion
Gestion=Personalizar
Personalizar=Filtros
Filtros=(Fin)
