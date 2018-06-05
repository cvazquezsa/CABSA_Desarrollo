[Forma]
Clave=CentroCostosRamaLista
Nombre=Centros de Costos
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
PosicionInicialIzquierda=275
PosicionInicialArriba=204
PosicionInicialAltura=364
PosicionInicialAncho=730
EsConsultaExclusiva=S
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=459

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CentroCostosLista
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=CentroGrupo
FiltroAncho=30
FiltroTipo=Arbol
FiltroTodoNombre=Centros de Costos
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
MenuLocal=S
ListaAcciones=SeleccionarTodo
FiltroGrupo1=CentroCostos.Grupo
FiltroValida1=CentroCostos.Grupo
FiltroGrupo2=CentroCostos.SubGrupo
FiltroValida2=CentroCostos.SubGrupo
FiltroArbolClave=CentroCostosLista.CentroCostos
FiltroArbolValidar=CentroCostosLista.Descripcion
FiltroArbolRama=CentroCostosLista.Rama
FiltroTodo=S
HojaTitulos=S
HojaMostrarColumnas=S
FiltroArbolAcumulativas=CentroCostosLista.EsAcumulativo
BusquedaRapidaControles=S
FiltroEstatus=S
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

[Lista.Columnas]
CentroCostos=127
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

[Lista.CentroCostosLista.CentroCostos]
Carpeta=Lista
Clave=CentroCostosLista.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CentroCostosLista.Descripcion]
Carpeta=Lista
Clave=CentroCostosLista.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=CentroCostosLista.CentroCostos
CentroCostosLista.CentroCostos=CentroCostosLista.Descripcion
CentroCostosLista.Descripcion=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)
