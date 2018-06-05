
[Forma]
Clave=PCPPendiente
Icono=0
Modulos=(Todos)
Nombre=Planeación Presupuestal - Movimientos Pendientes

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
PosicionInicialAlturaCliente=521
PosicionInicialAncho=531
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=374
PosicionInicialArriba=88
Comentarios=Lista(Info.Proyecto)
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PCPPendiente
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

ListaEnCaptura=(Lista)
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroProyectos=S
FiltroFechasCampo=PCPPendiente.FechaEmision
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=PCPPendiente:PCPPendiente.Movimiento
FiltroGeneral=PCPPendiente.MovTipo = ISNULL(NULLIF({Comillas(Info.MovTipo)},<T><T>),PCPPendiente.MovTipo) AND<BR>PCPPendiente.Estatus = ISNULL(NULLIF({Comillas(Info.Estatus)},<T><T>),PCPPendiente.Estatus) AND<BR>PCPPendiente.Proyecto = ISNULL(NULLIF({Comillas(Info.Proyecto)},<T><T>),PCPPendiente.Proyecto) AND<BR>PCPPendiente.Mov = ISNULL(NULLIF({Comillas(Info.Mov)},<T><T>),PCPPendiente.Mov)
[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S
NombreEnBoton=S


[Lista.PCPPendiente.Proyecto]
Carpeta=Lista
Clave=PCPPendiente.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.PCPPendiente.Categoria]
Carpeta=Lista
Clave=PCPPendiente.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=1
ColorFondo=Blanco

[Lista.PCPPendiente.FechaEmision]
Carpeta=Lista
Clave=PCPPendiente.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.PCPPendiente.Concepto]
Carpeta=Lista
Clave=PCPPendiente.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.PCPPendiente.Usuario]
Carpeta=Lista
Clave=PCPPendiente.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco




[Lista.PCPPendiente.Sucursal]
Carpeta=Lista
Clave=PCPPendiente.Sucursal
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
6=-2





[Lista.ListaEnCaptura]
(Inicio)=PCPPendiente.Proyecto
PCPPendiente.Proyecto=PCPPendiente.Categoria
PCPPendiente.Categoria=PCPPendiente.FechaEmision
PCPPendiente.FechaEmision=PCPPendiente.Concepto
PCPPendiente.Concepto=PCPPendiente.Usuario
PCPPendiente.Usuario=PCPPendiente.Sucursal
PCPPendiente.Sucursal=(Fin)
