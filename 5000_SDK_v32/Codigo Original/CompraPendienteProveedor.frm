[Forma]
Clave=CompraPendienteProveedor
Nombre=Compras Pendientes del Proveedor
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=263
PosicionInicialArriba=329
PosicionInicialAlturaCliente=331
PosicionInicialAncho=753
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Proveedor, Info.Almacen)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraPendiente
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
IconosSubTitulo=<T>Movimiento<T>
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PestanaOtroNombre=S
BusquedaRapidaControles=S
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
IconosNombre=CompraPendiente:CompraPendiente.Mov+<T> <T>+CompraPendiente:CompraPendiente.MovID
FiltroGeneral=CompraPendiente.Empresa=<T>{Empresa}<T> AND<BR>CompraPendiente.Proveedor=<T>{Info.Proveedor}<T> AND<BR>CompraPendiente.Almacen=<T>{Info.Almacen}<T>

[Lista.CompraPendiente.FechaEmision]
Carpeta=Lista
Clave=CompraPendiente.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraPendiente.FechaRequerida]
Carpeta=Lista
Clave=CompraPendiente.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraPendiente.Saldo]
Carpeta=Lista
Clave=CompraPendiente.Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=175
1=132

[Lista.CompraPendiente.Moneda]
Carpeta=Lista
Clave=CompraPendiente.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.SinOrden]
Nombre=SinOrden
Boton=25
NombreEnBoton=S
NombreDesplegar=&Recibir Sin Orden
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
EspacioPrevio=S
Antes=S
AntesExpresiones=Asigna(Info.ID, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.MovID, Nulo)

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(CompraPendiente:CompraPendiente.ID)
AntesExpresiones=Asigna(Info.ID, CompraPendiente:CompraPendiente.ID)<BR>Asigna(Info.Mov, CompraPendiente:CompraPendiente.Mov)<BR>Asigna(Info.MovID, CompraPendiente:CompraPendiente.MovID)

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=SinOrden
SinOrden=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CompraPendiente.FechaEmision
CompraPendiente.FechaEmision=CompraPendiente.FechaRequerida
CompraPendiente.FechaRequerida=CompraPendiente.Saldo
CompraPendiente.Saldo=CompraPendiente.Moneda
CompraPendiente.Moneda=(Fin)
