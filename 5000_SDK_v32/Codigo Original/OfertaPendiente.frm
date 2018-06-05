[Forma]
Clave=OfertaPendiente
Nombre=Oferta Pendiente
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=179
PosicionInicialArriba=246
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
Vista=OfertaPendiente
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
FiltroValida4=Fabricante
FiltroAplicaEn1=Art.Categoria
FiltroAplicaEn2=Art.Grupo
FiltroAplicaEn3=Art.Familia
FiltroAplicaEn4=Art.Fabricante
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
FiltroFechasCampo=OfertaPendiente.FechaRequerida
FiltroFechasDefault=(Todo)
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroFechasNormal=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=OfertaPendiente:OfertaPendiente.Articulo
FiltroGeneral=OfertaPendiente.Empresa=<T>{Empresa}<T> 

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

[Lista.OfertaPendiente.SubCuenta]
Carpeta=Lista
Clave=OfertaPendiente.SubCuenta
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

[Lista.OfertaPendiente.Almacen]
Carpeta=Lista
Clave=OfertaPendiente.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OfertaPendiente.CantidadPendiente]
Carpeta=Lista
Clave=OfertaPendiente.CantidadPendiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OfertaPendiente.Unidad]
Carpeta=Lista
Clave=OfertaPendiente.Unidad
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

[Lista.OfertaPendiente.FechaRequerida]
Carpeta=Lista
Clave=OfertaPendiente.FechaRequerida
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
EjecucionCondicion=ConDatos(OfertaPendiente:OfertaPendiente.ID)
AntesExpresiones=Asigna(Info.Modulo, OfertaPendiente:OfertaPendiente.Modulo)<BR>Asigna(Info.ID, OfertaPendiente:OfertaPendiente.ID)

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
EjecucionCondicion=ConDatos(OfertaPendiente:OfertaPendiente.Articulo)
AntesExpresiones=Asigna(Info.Articulo, OfertaPendiente:OfertaPendiente.Articulo)

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
AntesExpresiones=RegistrarSeleccionIDRenglon(<T>Lista<T>, <T>OfertaPendiente.Modulo<T>, <T>OfertaPendiente.ID<T>, <T>OfertaPendiente.Renglon<T>, <T>OfertaPendiente.RenglonSub<T>) <BR>EjecutarSQL(<T>spOfertaAceptar :nEstacion, :tModulo, :nID, :tMovTipo<T>, EstacionTrabajo, Info.Modulo, Info.ID, Info.MovTipo)

[Lista.OfertaPendiente.Proveedor]
Carpeta=Lista
Clave=OfertaPendiente.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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
Art.Descripcion1=OfertaPendiente.SubCuenta
OfertaPendiente.SubCuenta=MovimientoNombre
MovimientoNombre=OfertaPendiente.FechaRequerida
OfertaPendiente.FechaRequerida=OfertaPendiente.Proveedor
OfertaPendiente.Proveedor=OfertaPendiente.Almacen
OfertaPendiente.Almacen=OfertaPendiente.CantidadPendiente
OfertaPendiente.CantidadPendiente=OfertaPendiente.Unidad
OfertaPendiente.Unidad=(Fin)

[Lista.ListaOrden]
(Inicio)=OfertaPendiente.FechaRequerida<TAB>(Acendente)
OfertaPendiente.FechaRequerida<TAB>(Acendente)=OfertaPendiente.Articulo<TAB>(Acendente)
OfertaPendiente.Articulo<TAB>(Acendente)=OfertaPendiente.SubCuenta<TAB>(Acendente)
OfertaPendiente.SubCuenta<TAB>(Acendente)=(Fin)

[Lista.ListaAcciones]
(Inicio)=TodoLocal
TodoLocal=QuitarLocal
QuitarLocal=(Fin)
