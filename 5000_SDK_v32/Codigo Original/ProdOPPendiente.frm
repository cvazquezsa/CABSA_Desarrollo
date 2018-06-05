[Forma]
Clave=ProdOPPendiente
Nombre=Ordenes Pendientes
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=189
PosicionInicialArriba=161
PosicionInicialAltura=446
PosicionInicialAncho=646
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
EsConsultaExclusiva=S
SinCondicionDespliege=S
Comentarios=Si(ConDatos(Info.Centro), <T>Centro Trabajo: <T>+Info.Centro)
VentanaEscCerrar=S

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProdCopiar
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaOrden=ProdD.ProdSerieLote<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Pendientes
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Prod.FechaEmision
FiltroFechasDefault=(Todo)
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroTodo=S
IconosSeleccionMultiple=S
ListaEnCaptura=(Lista)
FiltroFechasNormal=S
FiltroAutoCampo=ProdD.Referencia
FiltroAutoValidar=ProdD.Referencia
FiltroGrupo1=ProdD.Referencia
FiltroValida1=ProdD.Referencia
IconosNombre=ProdCopiar:Prod.Mov+<T> <T>+ProdCopiar:Prod.MovID
FiltroGeneral=Prod.Empresa=<T>{Empresa}<T> AND Prod.Estatus=<T>PENDIENTE<T><BR>AND Prod.Mov IN ({MovListaSQL(<T>PROD<T>, PROD.O)})<BR>{Si(ConDatos(Info.Centro), <T> AND ProdD.Centro = <T>+Comillas(Info.Centro), <T><T>)}

[Lista.Columnas]
0=132
1=91

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

[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=55
NombreEnBoton=S
NombreDesplegar=Seleccionar &Todo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
NombreDesplegar=Información del Producto
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ProdProducto:Prod.Producto)
AntesExpresiones=Asigna(Info.Articulo, ProdProducto:Prod.Producto)

[Acciones.MovPropiedades]
Nombre=MovPropiedades
Boton=35
NombreDesplegar=Propiedades
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ProdProducto:Prod.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>PROD<T>)<BR>Asigna(Info.ID, ProdProducto:Prod.ID)

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

[Lista.ProdD.Articulo]
Carpeta=Lista
Clave=ProdD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdD.Unidad]
Carpeta=Lista
Clave=ProdD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdD.SubCuenta]
Carpeta=Lista
Clave=ProdD.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdD.Cantidad]
Carpeta=Lista
Clave=ProdD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdD.ProdSerieLote]
Carpeta=Lista
Clave=ProdD.ProdSerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdD.Centro]
Carpeta=Lista
Clave=ProdD.Centro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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
AntesExpresiones=RegistrarSeleccionIDRenglon(<T>Lista<T>, <T>PROD<T>, <T>Prod.ID<T>, <T>ProdD.Renglon<T>, <T>ProdD.RenglonSub<T>) <BR>EjecutarSQL(<T>spProdAceptar :nEstacion, :nID, :tMovTipo<T>, EstacionTrabajo, Info.ID, Info.MovTipo)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Agregar
Agregar=Cancelar
Cancelar=Seleccionar Todo
Seleccionar Todo=ArtInfo
ArtInfo=MovPropiedades
MovPropiedades=Campos
Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ProdD.ProdSerieLote
ProdD.ProdSerieLote=ProdD.Articulo
ProdD.Articulo=ProdD.SubCuenta
ProdD.SubCuenta=ProdD.Cantidad
ProdD.Cantidad=ProdD.Unidad
ProdD.Unidad=ProdD.Centro
ProdD.Centro=(Fin)
