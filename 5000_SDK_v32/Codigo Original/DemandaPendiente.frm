[Forma]
Clave=DemandaPendiente
Nombre=Demanda Pendiente
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=239
PosicionInicialArriba=259
PosicionInicialAltura=460
PosicionInicialAncho=921
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Si(Info.SeCompra y Info.SeProduce, <T>Almacén: <T>+Info.Almacen, Si(Info.SeProduce, <T>Artículos - Producción<T>, <T>Artículos - Compras<T>))
ListaAcciones=(Lista)
VentanaExclusiva=S
PosicionInicialAlturaCliente=505

[Ventas.Columnas]
0=96
1=148

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Pendientes
Clave=Lista
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DemandaPendiente
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
IconosSeleccionMultiple=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=(Lista)
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtFam
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=ArtLinea
FiltroAplicaEn1=Art.Categoria
FiltroAplicaEn2=Art.Grupo
FiltroAplicaEn3=Art.Familia
FiltroAplicaEn4=Art.Linea
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroTodoFinal=S
FiltroAncho=20
FiltroListas=S
FiltroListasRama=INV
FiltroListasAplicaEn=Art.Articulo
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=DemandaPendiente.FechaRequerida
FiltroFechasDefault=(Todo)
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroFechasNormal=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=DemandaPendiente:DemandaPendiente.Articulo
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=Fabricante
FiltroAplicaEn5=Art.Fabricante
FiltroGeneral=DemandaPendiente.Empresa=<T>{Empresa}<T> <BR>{<BR>Si(Info.SeProduce y Info.SeCompra, <T> AND DemandaPendiente.Almacen=<T>+Comillas(Info.Almacen), <BR>Si(Info.SeProduce, <T> AND DemandaPendiente.ArtSeProduce=<T>+LogicoEnBit(Info.SeProduce), <T><T>)+<BR>Si(Info.SeCompra, <T> AND DemandaPendiente.ArtSeCompra=<T>+LogicoEnBit(Info.SeCompra), <T><T>))<BR>}

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DemandaPendiente.SubCuenta]
Carpeta=Lista
Clave=DemandaPendiente.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovimientoNombre]
Carpeta=Lista
Clave=MovimientoNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DemandaPendiente.Cliente]
Carpeta=Lista
Clave=DemandaPendiente.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DemandaPendiente.Almacen]
Carpeta=Lista
Clave=DemandaPendiente.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DemandaPendiente.CantidadPendiente]
Carpeta=Lista
Clave=DemandaPendiente.CantidadPendiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DemandaPendiente.Unidad]
Carpeta=Lista
Clave=DemandaPendiente.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=93
1=138

[Acciones.Todo]
Nombre=Todo
Boton=55
NombreEnBoton=S
NombreDesplegar=Seleccionar &Todo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Lista.DemandaPendiente.FechaRequerida]
Carpeta=Lista
Clave=DemandaPendiente.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.TodoLocal]
Nombre=TodoLocal
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.QuitarLocal]
Nombre=QuitarLocal
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=Propiedades
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(DemandaPendiente:DemandaPendiente.ID)
AntesExpresiones=Asigna(Info.Modulo, DemandaPendiente:DemandaPendiente.Modulo)<BR>Asigna(Info.ID, DemandaPendiente:DemandaPendiente.ID)

[Acciones.Informacion]
Nombre=Informacion
Boton=34
NombreDesplegar=Información del Artículo
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(DemandaPendiente:DemandaPendiente.Articulo)
AntesExpresiones=Asigna(Info.Articulo, DemandaPendiente:DemandaPendiente.Articulo)

[Acciones.Agregar]
Nombre=Agregar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Agregar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Antes=S
Visible=S
AntesExpresiones=RegistrarSeleccionIDRenglon(<T>Lista<T>, <T>DemandaPendiente.Modulo<T>, <T>DemandaPendiente.ID<T>, <T>DemandaPendiente.Renglon<T>, <T>DemandaPendiente.RenglonSub<T>) <BR>EjecutarSQL(<T>spDemandaAceptar :nEstacion, :tModulo, :nID, :tMovTipo<T>, EstacionTrabajo, Info.Modulo, Info.ID, Info.MovTipo)

[Forma.ListaAcciones]
(Inicio)=Agregar
Agregar=Cancelar
Cancelar=Todo
Todo=Informacion
Informacion=Propiedades
Propiedades=Campos
Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=DemandaPendiente.SubCuenta
DemandaPendiente.SubCuenta=MovimientoNombre
MovimientoNombre=DemandaPendiente.FechaRequerida
DemandaPendiente.FechaRequerida=DemandaPendiente.Cliente
DemandaPendiente.Cliente=DemandaPendiente.Almacen
DemandaPendiente.Almacen=DemandaPendiente.CantidadPendiente
DemandaPendiente.CantidadPendiente=DemandaPendiente.Unidad
DemandaPendiente.Unidad=(Fin)

[Lista.ListaOrden]
(Inicio)=DemandaPendiente.FechaRequerida<TAB>(Acendente)
DemandaPendiente.FechaRequerida<TAB>(Acendente)=DemandaPendiente.Articulo<TAB>(Acendente)
DemandaPendiente.Articulo<TAB>(Acendente)=DemandaPendiente.SubCuenta<TAB>(Acendente)
DemandaPendiente.SubCuenta<TAB>(Acendente)=(Fin)

[Lista.ListaAcciones]
(Inicio)=TodoLocal
TodoLocal=QuitarLocal
QuitarLocal=(Fin)
