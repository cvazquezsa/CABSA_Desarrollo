
[Forma]
Clave=ProyClavePresupuestalReglaList
Icono=0
Modulos=(Todos)

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=409
PosicionInicialAncho=509
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=385
PosicionInicialArriba=139
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyClavePresupuestalRegla
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosSubTitulo=<T>ID<T>
ListaEnCaptura=(Lista)


Filtros=S
BusquedaRapidaControles=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
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
FiltroEstatus=S
FiltroListaEstatus=(Lista)
IconosNombre=ProyClavePresupuestalRegla:ProyClavePresupuestalRegla.RID
FiltroGeneral=ProyClavePresupuestalRegla.Proyecto = {Comillas(Info.Proyecto)}
FiltroEstatusDefault=(Todos)
[Lista.ProyClavePresupuestalRegla.Descripcion]
Carpeta=Lista
Clave=ProyClavePresupuestalRegla.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ProyClavePresupuestalRegla.Mascara]
Carpeta=Lista
Clave=ProyClavePresupuestalRegla.Mascara
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ProyClavePresupuestalRegla.Tipo]
Carpeta=Lista
Clave=ProyClavePresupuestalRegla.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ProyClavePresupuestalRegla.Estatus]
Carpeta=Lista
Clave=ProyClavePresupuestalRegla.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.ProyClavePresupuestalRegla.Orden]
Carpeta=Lista
Clave=ProyClavePresupuestalRegla.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
0=-2
1=-2
2=-2
3=-2
4=-2
5=-2









[Lista.ListaEnCaptura]
(Inicio)=ProyClavePresupuestalRegla.Descripcion
ProyClavePresupuestalRegla.Descripcion=ProyClavePresupuestalRegla.Mascara
ProyClavePresupuestalRegla.Mascara=ProyClavePresupuestalRegla.Tipo
ProyClavePresupuestalRegla.Tipo=ProyClavePresupuestalRegla.Estatus
ProyClavePresupuestalRegla.Estatus=ProyClavePresupuestalRegla.Orden
ProyClavePresupuestalRegla.Orden=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ACTIVO
ACTIVO=INACTIVO
INACTIVO=(Fin)
