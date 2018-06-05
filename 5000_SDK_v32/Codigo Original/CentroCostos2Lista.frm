[Forma]
Clave=CentroCostos2Lista
Nombre=Centros de Costos 2
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Di�logo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
PosicionInicialIzquierda=355
PosicionInicialArriba=191
PosicionInicialAltura=364
PosicionInicialAncho=730
EsConsultaExclusiva=S
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=484
VentanaEstadoInicial=Normal

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CentroCostos2Lista
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=CentroGrupo
FiltroAncho=30
FiltroTipo=M�ltiple (por Grupos)
FiltroTodoNombre=Todos
FiltroNullNombre=(sin agrupar)
FiltroRespetar=S
MenuLocal=S
ListaAcciones=SeleccionarTodo
FiltroGrupo1=CentroCostos2Lista.Grupo
FiltroValida1=CentroCostos2Lista.Grupo
FiltroGrupo2=CentroCostos2Lista.SubGrupo
FiltroValida2=CentroCostos2Lista.SubGrupo
FiltroArbolClave=CentroCostos2Lista.CentroCostos2
FiltroArbolValidar=CentroCostos2Lista.Descripcion
FiltroArbolRama=CentroCostos2Lista.Rama
FiltroArbolAcumulativas=CentroCostos2Lista.EsAcumulativo
FiltroTodo=S
HojaTitulos=S
HojaMostrarColumnas=S
FiltroGrupo3=CentroCostos2Lista.SubSubGrupo
FiltroValida3=CentroCostos2Lista.SubSubGrupo
FiltroNull=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
HojaColoresPorEstatus=S

FiltroGeneral=CentroCostos2Lista.EsAcumulativo=0
FiltroEstatus=S
[Lista.Columnas]
CentroCostos2=127
Grupo=157
Descripcion=235

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

[Acciones.SeleccionarTodo]
Nombre=SeleccionarTodo
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Lista.CentroCostos2Lista.CentroCostos2]
Carpeta=Lista
Clave=CentroCostos2Lista.CentroCostos2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.CentroCostos2Lista.Descripcion]
Carpeta=Lista
Clave=CentroCostos2Lista.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



[Lista.ListaEnCaptura]
(Inicio)=CentroCostos2Lista.CentroCostos2
CentroCostos2Lista.CentroCostos2=CentroCostos2Lista.Descripcion
CentroCostos2Lista.Descripcion=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)
