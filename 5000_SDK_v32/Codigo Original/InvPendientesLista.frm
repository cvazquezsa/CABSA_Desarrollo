[Forma]
Clave=InvPendientesLista
Nombre=<T>Pendientes<T>
Icono=0
Modulos=INV
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=204
PosicionInicialArriba=221
PosicionInicialAltura=351
PosicionInicialAncho=872
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaEscCerrar=S
PosicionInicialAlturaCliente=324

VentanaEstadoInicial=Normal
EsMovimiento=S
TituloAuto=S
MovEspecificos=Todos
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=InvPendientes
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosSubTitulo=<T>Movimiento<T>
ListaEnCaptura=(Lista)
PestanaNombre=Movimientos
Filtros=S
FiltroPredefinido=S
FiltroTipo=Múltiple (por Grupos)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30

PestanaOtroNombre=S
OtroOrden=S
BusquedaRapidaControles=S
MostrarConteoRegistros=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha

ListaOrden=Inv.ID<TAB>(Acendente)
FiltroTodo=S
FiltroTodoFinal=S
BusquedaRapida=S
BusquedaEnLinea=S
BusquedaInicializar=S
BusquedaRespetarControles=S
FiltroFechas=S
FiltroFechasCampo=Inv.FechaEmision
FiltroFechasDefault=(Todo)
FiltroAplicaEn=Inv.Mov
FiltroGrupo1=Inv.Mov
FiltroValida1=Inv.Mov
IconosNombre=InvPendientes:Inv.Mov+<T> <T>+InvPendientes:Inv.MovID
[Lista.Columnas]
0=148
1=89

2=-2
3=91
4=97
5=121
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

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
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


























[Lista.ListaEnCaptura]
(Inicio)=Inv.FechaEmision
Inv.FechaEmision=Inv.FechaRequerida
Inv.FechaRequerida=Inv.Almacen
Inv.Almacen=Inv.AlmacenDestino
Inv.AlmacenDestino=Inv.Referencia
Inv.Referencia=(Fin)

[Lista.Inv.FechaEmision]
Carpeta=Lista
Clave=Inv.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Inv.FechaRequerida]
Carpeta=Lista
Clave=Inv.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Inv.Almacen]
Carpeta=Lista
Clave=Inv.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Inv.AlmacenDestino]
Carpeta=Lista
Clave=Inv.AlmacenDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Inv.Referencia]
Carpeta=Lista
Clave=Inv.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

















[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Cancelar
Cancelar=Personalizar
Personalizar=(Fin)
