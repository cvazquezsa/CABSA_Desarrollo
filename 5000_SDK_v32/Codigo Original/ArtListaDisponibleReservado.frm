[Forma]
Clave=ArtListaDisponibleReservado
Nombre=e(<T>Existencias Disponibles<T>)+<T> - <T>+Info.Almacen
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=34
PosicionInicialArriba=87
PosicionInicialAltura=466
PosicionInicialAncho=914
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaEscCerrar=S
BarraHerramientas=S
Comentarios=Si(ConDatos(Info.AlmGrupo), e(<T>Grupo<T>)+<T>: <T>+Info.AlmGrupo, e(<T>Almacén<T>)+<T>: <T>+Si(ConDatos(Info.Almacen), Info.Almacen, <T>(Todos)<T>))
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=552

VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.AlmGrupo, Nulo)<BR>Asigna(Info.Almacen, Nulo)
[ArtDisponibleReservado]
Estilo=Hoja
Pestana=
Clave=ArtDisponibleReservado
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtDisponibleReservado
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=30
Filtros=
BusquedaAVariable=
BusquedaEnLinea=S

[ArtDisponibleReservado.Columnas]
Articulo_1=109
Descripcion1=203
Descripcion2=1534
Almacen=51
SubCuenta=103
Disponible=57
Articulo=115
Unidad=49
Tipo=124
PrecioLista=70

[ArtDisponibleReservado.Disponible]
Carpeta=ArtDisponibleReservado
Clave=Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[ArtDisponibleReservado.Articulo]
Carpeta=ArtDisponibleReservado
Clave=Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S

[ArtDisponibleReservado.Descripcion1]
Carpeta=ArtDisponibleReservado
Clave=Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S

[ArtDisponibleReservado.PrecioLista]
Carpeta=ArtDisponibleReservado
Clave=PrecioLista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S

[Lista]
Estilo=Iconos
Clave=Lista
BusquedaRapidaControles=S
Zona=A1
Vista=ArtDisponibleReservadoDesc
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=22
BusquedaEnLinea=S
FiltroFechasNormal=S
Filtros=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtCat
FiltroPredefinido=S
FiltroAplicaEn=Categoria
FiltroAncho=22
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroTodoFinal=S
FiltroNullNombre=(sin clategoría)
FiltroRespetar=S
FiltroAplicaEn1=Art.Categoria
FiltroListas=S
FiltroListasRama=INV
FiltroListasAplicaEn=Art.Articulo
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtGrupo
FiltroAplicaEn2=Art.Grupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtFam
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=ArtLinea
FiltroAplicaEn3=Art.Familia
FiltroAplicaEn4=Art.Linea
OtroOrden=S
ListaOrden=Art.Articulo<TAB>(Acendente)
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
PermiteLocalizar=S
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=Fabricante
FiltroAplicaEn5=Art.Fabricante
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
PestanaOtroNombre=S
MostrarConteoRegistros=S
FiltroSituacionTodo=S
MenuLocal=S
ListaAcciones=(Lista)

IconosNombre=ArtDisponibleReservadoDesc:Art.Articulo
FiltroGrupo6=(Validaciones Memoria)
FiltroValida6=ArtTipo
FiltroAplicaEn6=Art.Tipo
FiltroGeneral=ArtDisponibleReservado.Empresa=<T>{Empresa}<T> <BR>{Si(ConDatos(Info.AlmGrupo), <T> AND Alm.Grupo=<T>+Comillas(Info.AlmGrupo), Si(ConDatos(Info.Almacen), <T> AND ArtDisponibleReservado.Almacen=<T>+Comillas(Info.Almacen), <T><T>))}
[Lista.Columnas]
Articulo=92
Descripcion1=224
PrecioLista=71
Disponible=57
Tipo=46
0=112
1=183
EstatusNombre=77

2=-2
3=-2
4=-2
5=-2
6=-2
[Acciones.Info]
Nombre=Info
Boton=34
NombreEnBoton=S
NombreDesplegar=&Artículo
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
ConCondicion=S
Expresion=Asigna(Filtro.Almacen, Info.Almacen)<BR>Forma(<T>ArtInfo<T>)<BR>Asigna(Info.Almacen, Filtro.Almacen)
EjecucionCondicion=ConDatos(ArtDisponibleReservadoDesc:Art.Articulo)
AntesExpresiones=Asigna(Info.Articulo, ArtDisponibleReservadoDesc:Art.Articulo)

[Art.Art.Articulo]
Carpeta=Art
Clave=Art.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Art.Art.Descripcion1]
Carpeta=Art
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100

[Art.Columnas]
Articulo=124
Descripcion1=244

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
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

[Acciones.Almacen]
Nombre=Almacen
Boton=16
NombreEnBoton=S
NombreDesplegar=&Almacén
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
ConCondicion=S
Visible=S
ActivoCondicion=Vacio(Info.AlmGrupo)
EjecucionCondicion=Forma(<T>EspecificarAlmacen<T>)

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Art.PrecioLista]
Carpeta=Lista
Clave=Art.PrecioLista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtDisponibleReservado.Disponible]
Carpeta=Lista
Clave=ArtDisponibleReservado.Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Totalizador=1

[Acciones.Grupo]
Nombre=Grupo
Boton=87
NombreEnBoton=S
NombreDesplegar=&Grupo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=Forma(<T>EspecificarAlmGrupo<T>)

[Lista.ArtDisponibleReservado.Almacen]
Carpeta=Lista
Clave=ArtDisponibleReservado.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.ArtCompraPendiente]
Nombre=ArtCompraPendiente
Boton=0
NombreDesplegar=C&ompras Pendientes
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtCompraPendiente
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+O
EjecucionCondicion=ConDatos(ArtDisponibleReservadoDesc:ArtDisponibleReservado.Articulo)
AntesExpresiones=Asigna(Info.Articulo, ArtDisponibleReservadoDesc:ArtDisponibleReservado.Articulo)<BR>Asigna(Info.Almacen, Nulo)

[Acciones.ArtVentaPendiente]
Nombre=ArtVentaPendiente
Boton=0
NombreDesplegar=&Ventas Pendientes
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtVentaPendiente
Activo=S
Visible=S
Antes=S
ConCondicion=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+V
EjecucionCondicion=ConDatos(ArtDisponibleReservadoDesc:ArtDisponibleReservado.Articulo)
AntesExpresiones=Asigna(Info.Articulo, ArtDisponibleReservadoDesc:ArtDisponibleReservado.Articulo)<BR>Asigna(Info.Almacen, ArtDisponibleReservadoDesc:ArtDisponibleReservado.Almacen)

[Acciones.LocalArtInfo]
Nombre=LocalArtInfo
Boton=0
NombreDesplegar=Información del Artículo
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
ConCondicion=S
Visible=S
EjecucionCondicion=ConDatos(ArtDisponibleReservadoDesc:ArtDisponibleReservado.Articulo)
Antes=S
AntesExpresiones=Asigna(Info.Articulo, ArtDisponibleReservadoDesc:ArtDisponibleReservado.Articulo)

[Lista.ArtDisponibleReservado.Reservado]
Carpeta=Lista
Clave=ArtDisponibleReservado.Reservado
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Existencia]
Carpeta=Lista
Clave=Existencia
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.ArtSolicitudPendiente]
Nombre=ArtSolicitudPendiente
Boton=0
NombreDesplegar=&Solicitudes (Inventario) Pendientes
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtSolicitudPendiente
Activo=S
Visible=S
ConCondicion=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+S
EjecucionCondicion=ConDatos(ArtDisponibleReservadoDesc:ArtDisponibleReservado.Articulo)
AntesExpresiones=Asigna(Info.Articulo, ArtDisponibleReservadoDesc:ArtDisponibleReservado.Articulo)<BR>Asigna(Info.Almacen, ArtDisponibleReservadoDesc:ArtDisponibleReservado.Almacen)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Info
Info=Almacen
Almacen=Grupo
Grupo=Campos
Campos=(Fin)

[ArtDisponibleReservado.ListaEnCaptura]
(Inicio)=Articulo
Articulo=Descripcion1
Descripcion1=PrecioLista
PrecioLista=Disponible
Disponible=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=Art.PrecioLista
Art.PrecioLista=ArtDisponibleReservado.Disponible
ArtDisponibleReservado.Disponible=ArtDisponibleReservado.Reservado
ArtDisponibleReservado.Reservado=Existencia
Existencia=ArtDisponibleReservado.Almacen
ArtDisponibleReservado.Almacen=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PROTOTIPO
PROTOTIPO=ALTA
ALTA=BLOQUEADO
BLOQUEADO=DESCONTINUADO
DESCONTINUADO=BAJA
BAJA=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalArtInfo
LocalArtInfo=ArtCompraPendiente
ArtCompraPendiente=ArtVentaPendiente
ArtVentaPendiente=ArtSolicitudPendiente
ArtSolicitudPendiente=(Fin)
