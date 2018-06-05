[Forma]
Clave=CompraDAsignar
Nombre=Movimientos Compras del Proveedor
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Proveedor, Info.Nombre)
PosicionInicialAltura=447
PosicionInicialAncho=818
EsMovimiento=S
EsConsultaExclusiva=S
MovModulo=COMS
TituloAuto=S
MovEspecificos=Todos
SinCondicionDespliege=S
PosicionInicialIzquierda=231
PosicionInicialArriba=288
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=420

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraT
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroEstatus=S
FiltroUsuarios=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSituacion=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=CONCLUIDO
FiltroUsuarioDefault=(Todos)
FiltroFechasCampo=Compra.FechaEmision
FiltroFechasDefault=Esta Semana
FiltroFechasNormal=S
FiltroFechasCancelacion=Compra.FechaCancelacion
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S
PestanaOtroNombre=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroMovDefault=(Todos)
IconosSeleccionMultiple=S
FiltroSituacionTodo=S
FiltroMonedas=S
FiltroMonedasCampo=Compra.Moneda
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=CompraT:CompraD.Articulo
FiltroGeneral=(Compra.Proveedor=<T>{Info.Proveedor}<T>) OR (CompraD.ImportacionProveedor=<T>{Info.Proveedor}<T>)

[Lista.Compra.FechaEmision]
Carpeta=Lista
Clave=Compra.FechaEmision
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraD.Almacen]
Carpeta=Lista
Clave=CompraD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraD.Cantidad]
Carpeta=Lista
Clave=CompraD.Cantidad
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraD.Costo]
Carpeta=Lista
Clave=CompraD.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CostoTotal]
Carpeta=Lista
Clave=CostoTotal
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Asignar]
Nombre=Asignar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Asignar
EnBarraHerramientas=S
TipoAccion=Ventana
Activo=S
Visible=S
ClaveAccion=Aceptar
Antes=S
AntesExpresiones=RegistrarSeleccionIDRenglon(<T>Lista<T>, <T>COMS<T>, <T>Compra.ID<T>, <T>CompraD.Renglon<T>, <T>CompraD.RenglonSub<T>)<BR>EjecutarSQL(<T>spCompraDAsignar :nEstacion, :nID<T>, EstacionTrabajo, Info.ID)

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

[Lista.Columnas]
0=99
1=156

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

[Lista.MovDesc]
Carpeta=Lista
Clave=MovDesc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=&Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.SeleccionarTodo]
Nombre=SeleccionarTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.QuitarSeleccion]
Nombre=QuitarSeleccion
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Asignar
Asignar=Cancelar
Cancelar=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=MovDesc
MovDesc=Compra.FechaEmision
Compra.FechaEmision=CompraD.Almacen
CompraD.Almacen=CompraD.Cantidad
CompraD.Cantidad=CompraD.Costo
CompraD.Costo=CostoTotal
CostoTotal=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=(Fin)

[Lista.ListaAcciones]
(Inicio)=SeleccionarTodo
SeleccionarTodo=QuitarSeleccion
QuitarSeleccion=(Fin)
