[Forma]
Clave=ProyectoDRecurso
Nombre=Recursos Asignados
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=540
PosicionInicialArriba=387
PosicionInicialAlturaCliente=390
PosicionInicialAncho=839
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Proyecto, Info.Actividad, Info.Asunto)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyectoDRecurso
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Recurso<T>
ElementosPorPagina=200
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PestanaOtroNombre=S
PestanaNombre=Recursos
IconosNombre=ProyectoDRecurso:ProyectoDRecurso.Recurso
FiltroGeneral=ProyectoDRecurso.ID = {Info.ID} AND<BR>ProyectoDRecurso.Actividad = <T>{Info.Actividad}<T>

[Lista.Recurso.Nombre]
Carpeta=Lista
Clave=Recurso.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoRecurso.Rol]
Carpeta=Lista
Clave=ProyectoRecurso.Rol
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoDRecurso.Comienzo]
Carpeta=Lista
Clave=ProyectoDRecurso.Comienzo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoDRecurso.Fin]
Carpeta=Lista
Clave=ProyectoDRecurso.Fin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=102
1=260

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

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Recurso.Nombre
Recurso.Nombre=ProyectoRecurso.Rol
ProyectoRecurso.Rol=ProyectoDRecurso.Comienzo
ProyectoDRecurso.Comienzo=ProyectoDRecurso.Fin
ProyectoDRecurso.Fin=(Fin)
