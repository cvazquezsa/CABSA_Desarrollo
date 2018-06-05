[Forma]
Clave=ProyectoDTransferir
Nombre=Transferir Actividades Pendientes
Icono=29
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=556
PosicionInicialArriba=352
PosicionInicialAlturaCliente=459
PosicionInicialAncho=807
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Proyecto, Si(Ver.Todo, <T>Todas las Actividades<T>, <T>Actividades sin Asignar<T>))
VentanaExclusiva=S
ExpresionesAlMostrar=Asigna(Ver.Todo, Falso)
EsConsultaExclusiva=S

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
FiltroGeneral=ProyectoD.ID={Info.ID} AND ProyectoD.Estado NOT IN (<T>Completada<T>, <T>Cancelada<T>, <T>Eliminada<T>)<BR>{Si(no Ver.Todo, <T> AND (NOT EXISTS(SELECT * FROM ProyectoDRecurso WHERE Actividad=ProyectoD.Actividad AND ID = ProyectoD.ID))<T>, <T><T>)}

[Lista.Columnas]
0=79
1=339

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

[Acciones.Filtro]
Nombre=Filtro
Boton=107
NombreDesplegar=&Filtro
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Asigna(Ver.Todo, no Ver.Todo)

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
Expresion=Si<BR>  Forma(<T>EspecificarRecurso<T>)<BR>Entonces<BR>  RegistrarSeleccion(<T>Lista<T>)<BR>  EjecutarSQL(<T>spProyectoDAsignar :ID, :nEstacion, :tRecurso, @DesAsignar = 1<T>, Info.ID, EstacionTrabajo, Info.Recurso)<BR>  Forma.ActualizarForma<BR>Fin

[Lista.ProyectoD.Asunto]
Carpeta=Lista
Clave=ProyectoD.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoD.Tipo]
Carpeta=Lista
Clave=ProyectoD.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoD.RecursosAsignados]
Carpeta=Lista
Clave=ProyectoD.RecursosAsignados
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoD.Estado]
Carpeta=Lista
Clave=ProyectoD.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cancelar
Cancelar=Asignar
Asignar=Filtro
Filtro=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ProyectoD.Asunto
ProyectoD.Asunto=ProyectoD.Tipo
ProyectoD.Tipo=ProyectoD.Estado
ProyectoD.Estado=ProyectoD.RecursosAsignados
ProyectoD.RecursosAsignados=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=(Fin)
