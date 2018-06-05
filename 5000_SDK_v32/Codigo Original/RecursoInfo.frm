[Forma]
Clave=RecursoInfo
Nombre=Información del Recurso
Icono=0
BarraHerramientas=S
Modulos=(Todos)
MovModulo=(Todos)
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=184
PosicionInicialArriba=156
PosicionInicialAlturaCliente=614
PosicionInicialAncho=912
Comentarios=Lista(Info.Proyecto, Info.Recurso)

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

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RecursoInfo
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ActividadTipo
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ActCat
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ActGrupo
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=ActFam
FiltroAplicaEn1=ProyectoDInfo.Tipo
FiltroAplicaEn2=ProyectoDInfo.Categoria
FiltroAplicaEn3=ProyectoDInfo.Grupo
FiltroAplicaEn4=ProyectoDInfo.Familia
PestanaOtroNombre=S
PestanaNombre=Actividades
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Actividad<T>
ElementosPorPagina=200
FiltroTodo=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=ProyectoDInfo.Fin
FiltroFechasVencimiento=S
FiltroFechasNombre=&Vencimiento
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroFechasDefault=(Todo)
IconosNombre=RecursoInfo:ProyectoDInfo.Actividad
FiltroGeneral=ProyectoDInfo.ID = {Info.ID} AND<BR>ProyectoDRecurso.Recurso = <T>{Info.Recurso}<T>

[Lista.Columnas]
Mov=124
MovID=64
FechaEmision=94
Comienzo=94
Fin=94
Proyecto=304
Actividad=124
Asunto=180
Tipo=124
Comienzo_1=94
Fin_1=94
Estado=124
Avance_1=64
Duracion=64
DuracionUnidad=79
0=-2
1=214

[Lista.ProyectoDInfo.Asunto]
Carpeta=Lista
Clave=ProyectoDInfo.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoDInfo.Duracion]
Carpeta=Lista
Clave=ProyectoDInfo.Duracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoDInfo.DuracionUnidad]
Carpeta=Lista
Clave=ProyectoDInfo.DuracionUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoDInfo.Comienzo]
Carpeta=Lista
Clave=ProyectoDInfo.Comienzo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoDInfo.Fin]
Carpeta=Lista
Clave=ProyectoDInfo.Fin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoDInfo.Estado]
Carpeta=Lista
Clave=ProyectoDInfo.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoDInfo.Avance]
Carpeta=Lista
Clave=ProyectoDInfo.Avance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.preliminar]
Nombre=preliminar
Boton=6
NombreDesplegar=Presentacion preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Campos
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=preliminar
preliminar=Excel
Excel=Campos
Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ProyectoDInfo.Asunto
ProyectoDInfo.Asunto=ProyectoDInfo.Duracion
ProyectoDInfo.Duracion=ProyectoDInfo.DuracionUnidad
ProyectoDInfo.DuracionUnidad=ProyectoDInfo.Comienzo
ProyectoDInfo.Comienzo=ProyectoDInfo.Fin
ProyectoDInfo.Fin=ProyectoDInfo.Estado
ProyectoDInfo.Estado=ProyectoDInfo.Avance
ProyectoDInfo.Avance=(Fin)

[Lista.ListaOrden]
(Inicio)=ProyectoDInfo.ID<TAB>(Acendente)
ProyectoDInfo.ID<TAB>(Acendente)=ProyectoDInfo.Orden<TAB>(Acendente)
ProyectoDInfo.Orden<TAB>(Acendente)=(Fin)
