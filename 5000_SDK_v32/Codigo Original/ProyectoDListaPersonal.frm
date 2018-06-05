[Forma]
Clave=ProyectoDListaPersonal
Nombre=<T>Actividades del Proyecto<T>
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=629
PosicionInicialArriba=349
PosicionInicialAlturaCliente=466
PosicionInicialAncho=662
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Proyecto, Si(no Ver.Todo, <T>Liberadas<T>, <T>Todas las Actividades<T>))
ExpresionesAlMostrar=Asigna(Ver.Todo, Falso)

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Actividades
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyectoDEnFirme
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosSubTitulo=<T>Actividad<T>
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroAplicaEn=ProyectoDEnFirme.Estado
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=TareaEstado
IconosNombre=ProyectoDEnFirme:ProyectoDEnFirme.Actividad
FiltroGeneral=ProyectoDEnFirme.Proyecto=<T>{Info.Proyecto}<T><BR>{Si(no Ver.Todo, <T> AND ProyectoDEnFirme.EstaLiberado=1<T>,<T><T>)}<BR>{Si(ConDatos(Info.Recurso), <T> AND ProyectoDEnFirme.Actividad IN (SELECT r.Actividad<BR>                                                            FROM ProyectoDRecurso r<BR>                                                           WHERE r.ID = ProyectoDEnFirme.ID<BR>                                                             AND r.Actividad = ProyectoDEnFirme.Actividad<BR>                                                             AND r.Recurso = <T> + Comillas(Info.Recurso) + <T>)<T>, <T><T>)}

[Lista.Columnas]
0=94
1=297

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
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Filtro]
Nombre=Filtro
Boton=107
NombreEnBoton=S
NombreDesplegar=&Filtro
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Ver.Todo, no Ver.Todo)

[Lista.ProyectoDEnFirme.Asunto]
Carpeta=Lista
Clave=ProyectoDEnFirme.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoDEnFirme.Tipo]
Carpeta=Lista
Clave=ProyectoDEnFirme.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoDEnFirme.Comienzo]
Carpeta=Lista
Clave=ProyectoDEnFirme.Comienzo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoDEnFirme.Fin]
Carpeta=Lista
Clave=ProyectoDEnFirme.Fin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Filtro
Filtro=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ProyectoDEnFirme.Asunto
ProyectoDEnFirme.Asunto=ProyectoDEnFirme.Tipo
ProyectoDEnFirme.Tipo=ProyectoDEnFirme.Comienzo
ProyectoDEnFirme.Comienzo=ProyectoDEnFirme.Fin
ProyectoDEnFirme.Fin=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)
