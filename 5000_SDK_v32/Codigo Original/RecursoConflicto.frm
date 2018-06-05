[Forma]
Clave=RecursoConflicto
Nombre=Actividades en Conflicto
Icono=7
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=136
PosicionInicialArriba=180
PosicionInicialAlturaCliente=380
PosicionInicialAncho=752
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Recurso, FechaEnTexto(Info.FechaD, <T>dddd dd/mmm/aaaa<T>), FechaEnTexto(Info.FechaA, <T>dddd dd/mmm/aaaa<T>))
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Actividades
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Act
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=Act:Act.Actividad
FiltroGeneral=Act.Recurso=<T>{Info.Recurso}<T> AND <BR>Act.Estado<><T>Cancelada<T> AND <BR>Act.ID<>{Info.ActID} AND<BR>(Act.Comienzo BETWEEN <T>{FechaFormatoServidor(Info.FechaD)}<T> AND <T>{FechaFormatoServidor(Info.FechaA)}<T>) AND<BR>(Act.Fin      BETWEEN <T>{FechaFormatoServidor(Info.FechaD)}<T> AND <T>{FechaFormatoServidor(Info.FechaA)}<T>)

[Lista.Act.Asunto]
Carpeta=Lista
Clave=Act.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Act.Tipo]
Carpeta=Lista
Clave=Act.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Act.Comienzo]
Carpeta=Lista
Clave=Act.Comienzo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Act.Fin]
Carpeta=Lista
Clave=Act.Fin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Proyecto.Proyecto]
Carpeta=Lista
Clave=Proyecto.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=81
1=284

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
NombreDesplegar=Personalizar &Vista
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
(Inicio)=Act.Asunto
Act.Asunto=Act.Tipo
Act.Tipo=Proyecto.Proyecto
Proyecto.Proyecto=Act.Comienzo
Act.Comienzo=Act.Fin
Act.Fin=(Fin)
