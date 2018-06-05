
[Forma]
Clave=SAUXServicioLista
Icono=0
Modulos=(Todos)
MovModulo=SAUX
Nombre=Servicios

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialAlturaCliente=390
PosicionInicialAncho=722
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=439
PosicionInicialArriba=236
ListaAcciones=Seleccionar
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SAUXServicio
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)

Filtros=S
OtroOrden=S
BusquedaRapidaControles=S

ListaOrden=SAUXServicio.Servicio<TAB>(Acendente)
FiltroPredefinido=S
FiltroGrupo1=SAUXServicio.Categoria
FiltroValida1=SAUXServicio.Categoria
FiltroGrupo2=SAUXServicio.Grupo
FiltroValida2=SAUXServicio.Grupo
FiltroGrupo3=SAUXServicio.Familia
FiltroValida3=SAUXServicio.Familia
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroTodo=S
[Lista.SAUXServicio.Servicio]
Carpeta=Lista
Clave=SAUXServicio.Servicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.SAUXServicio.Descripcion]
Carpeta=Lista
Clave=SAUXServicio.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco





[Lista.Columnas]
Servicio=124
Descripcion=409

[Lista.ListaEnCaptura]
(Inicio)=SAUXServicio.Servicio
SAUXServicio.Servicio=SAUXServicio.Descripcion
SAUXServicio.Descripcion=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BAJA
BAJA=(Fin)

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S
