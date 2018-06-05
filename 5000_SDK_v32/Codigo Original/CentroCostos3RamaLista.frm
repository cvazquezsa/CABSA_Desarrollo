[Forma]
Clave=CentroCostos3RamaLista
Nombre=Centros de Costos 3
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
Vista=CentroCostos3Lista
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
FiltroGrupo1=CentroCostos3.Grupo
FiltroValida1=CentroCostos3.Grupo
FiltroGrupo2=CentroCostos3.SubGrupo
FiltroValida2=CentroCostos3.SubGrupo
FiltroArbolClave=CentroCostos3Lista.CentroCostos3
FiltroArbolValidar=CentroCostos3Lista.Descripcion
FiltroArbolRama=CentroCostos3Lista.Rama
FiltroTodo=S
HojaTitulos=S
HojaMostrarColumnas=S
FiltroArbolAcumulativas=CentroCostos3Lista.EsAcumulativo
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
CentroCostos3=127
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

[Lista.CentroCostos3Lista.CentroCostos3]
Carpeta=Lista
Clave=CentroCostos3Lista.CentroCostos3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CentroCostos3Lista.Descripcion]
Carpeta=Lista
Clave=CentroCostos3Lista.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=CentroCostos3Lista.CentroCostos3
CentroCostos3Lista.CentroCostos3=CentroCostos3Lista.Descripcion
CentroCostos3Lista.Descripcion=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)
