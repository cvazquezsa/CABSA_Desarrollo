
[Forma]
Clave=GestionMultipleProy
Icono=29
Nombre=Gestión Multiple

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=131
PosicionInicialArriba=179
PosicionInicialAlturaCliente=369
PosicionInicialAncho=959
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
Modulos=(Todos)
VentanaExclusiva=S
VentanaExclusivaOpcion=0
EsConsultaExclusiva=S
ExpresionesAlMostrar=Asigna(Ver.Todo, Verdadero)
Comentarios=Lista(Info.Proyecto, Info.Recurso, Info.Nombre, <T>Actividades sin Asignar<T>)
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

Vista=ProyectoD
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSeleccionMultiple=S
ElementosPorPaginaEsp=200
ListaEnCaptura=(Lista)
OtroOrden=S
ListaOrden=ProyectoD.Orden<TAB>(Acendente)
PestanaOtroNombre=S
PestanaNombre=Actividades
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
MenuLocal=S
ListaAcciones=(Lista)
IconosSubTitulo=<T>Actividad<T>
IconosNombre=ProyectoD:ProyectoD.Actividad
IconosConRejilla=S
FiltroGeneral=ProyectoD.ID={Info.ID} AND ProyectoD.Estado NOT IN (<T>Completada<T>, <T>Cancelada<T>, <T>Eliminada<T>) AND<BR>ProyectoD.IDGestion IS NULL AND<BR>{Si(ConDatos(Info.Aplica), <T>CASE WHEN LEN(Orden) = 5 THEN Orden ELSE LEFT(Orden, 5) END =<T>+Comillas(Info.Aplica),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoEstado), <T>ProyectoD.Estado=<T>+Comillas(Info.ProyectoEstado),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoRecurso), <T>ProyectoD.RecursosAsignados=<T>+Comillas(Info.ProyectoRecurso),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoAvanceD), <T>ISNULL(ProyectoD.Avance,0)>=<T>+Comillas(Info.ProyectoAvanceD),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoAvanceA), <T>ISNULL(ProyectoD.Avance,0)<=<T>+Comillas(Info.ProyectoAvanceA),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoFechaInicioD), <T>ProyectoD.Comienzo>=<T>+Comillas(FechaFormatoServidor(Info.ProyectoFechaInicioD)),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoFechaInicioA), <T>ProyectoD.Comienzo<=<T>+Comillas(FechaFormatoServidor(Info.ProyectoFechaInicioA)),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoFechaConclusionD), <T>ProyectoD.Fin>=<T>+Comillas(FechaFormatoServidor(Info.ProyectoFechaConclusionD)),<T>1=1<T>)} AND<BR>{Si(ConDatos(Info.ProyectoFechaConclusionA), <T>ProyectoD.Fin<=<T>+Comillas(FechaFormatoServidor(Info.ProyectoFechaConclusionA)),<T>1=1<T>)}
[Acciones.EnvioGestionMultiple]
Nombre=EnvioGestionMultiple
Boton=0
NombreDesplegar=&Enviar Gestión Multiple
EnMenu=S
TipoAccion=Expresion
Expresion=RegistrarSeleccion(<T>Lista<T>)
Activo=S
Visible=S




[Lista.ProyectoD.Asunto]
Carpeta=Lista
Clave=ProyectoD.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
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



[Lista.Columnas]
0=83
1=-2
2=-2
3=84
4=-2
5=-2
6=-2
7=-2
8=-2
9=-2
10=-2
11=-2
12=-2
13=-2
14=-2


[Acciones.EnviaGestion]
Nombre=EnviaGestion
Boton=29
NombreDesplegar=&Enviar a Gestión
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S







NombreEnBoton=S












EspacioPrevio=S

Visible=S
Expresion=RegistrarSeleccion(<T>Lista<T>)<BR>EjecutarSQL(<T>spProyectoGestionGenerarLote :nEstacion, :nID<T>, EstacionTrabajo, Info.ID)<BR>Forma.ActualizarForma
[Acciones.Cancelar]
Nombre=Cancelar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S












[Acciones.QuitarSeleccion]
Nombre=QuitarSeleccion
Boton=0
NombreDesplegar=&Quitar Selección
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.SeleccionTodo]
Nombre=SeleccionTodo
Boton=0
NombreDesplegar=&Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S























[Lista.ProyectoD.Avance]
Carpeta=Lista
Clave=ProyectoD.Avance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





[Lista.ProyectoD.Duracion]
Carpeta=Lista
Clave=ProyectoD.Duracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ProyectoD.DuracionUnidad]
Carpeta=Lista
Clave=ProyectoD.DuracionUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.ProyectoD.DuracionDias]
Carpeta=Lista
Clave=ProyectoD.DuracionDias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ProyectoD.Comienzo]
Carpeta=Lista
Clave=ProyectoD.Comienzo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ProyectoD.Fin]
Carpeta=Lista
Clave=ProyectoD.Fin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
























[Lista.ListaEnCaptura]
(Inicio)=ProyectoD.Asunto
ProyectoD.Asunto=ProyectoD.Avance
ProyectoD.Avance=ProyectoD.Estado
ProyectoD.Estado=ProyectoD.RecursosAsignados
ProyectoD.RecursosAsignados=ProyectoD.Duracion
ProyectoD.Duracion=ProyectoD.DuracionUnidad
ProyectoD.DuracionUnidad=ProyectoD.DuracionDias
ProyectoD.DuracionDias=ProyectoD.Comienzo
ProyectoD.Comienzo=ProyectoD.Fin
ProyectoD.Fin=(Fin)

[Lista.ListaAcciones]
(Inicio)=SeleccionTodo
SeleccionTodo=QuitarSeleccion
QuitarSeleccion=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cancelar
Cancelar=EnviaGestion
EnviaGestion=(Fin)
