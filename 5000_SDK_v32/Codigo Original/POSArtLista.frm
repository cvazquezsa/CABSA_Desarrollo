[Forma]
Clave=POSArtLista
Nombre=Artículos
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=2342
PosicionInicialArriba=265
PosicionInicialAltura=425
PosicionInicialAncho=1076
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S
MovModulo=INV
PosicionInicialAlturaCliente=480

[Lista]
Estilo=Hoja
Clave=Lista
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSArt
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
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=30
CarpetaVisible=S
Filtros=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtCat
FiltroPredefinido=S
FiltroAplicaEn=Art.Categoria
FiltroTipo=Ninguno
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin familia)
FiltroRespetar=S
FiltroAncho=25
HojaAjustarColumnas=S
FiltroClase=S
FiltroClaseTodo=S
FiltroFechasNormal=S
FiltroListas=S
FiltroListasRama=INV
FiltroListasAplicaEn=Art.Articulo
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
MenuLocal=S
ListaAcciones=(Lista)
OtroOrden=S
ListaOrden=Art.Articulo<TAB>(Acendente)
PermiteLocalizar=S
PestanaNombre=Artículos
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=Fabricante
FiltroAplicaEn5=Art.Fabricante
FiltroSituacionTodo=S

ListaEnCaptura=(Lista)
BusquedaAutoAsterisco=S

HojaColorFondo=Plata
FuenteBusqueda={MS Sans Serif, 8, Negro, []}
BusquedaLocal=S
CaracteresBusqueda=3
FiltroGeneral=Art.Tipo<><T>Estructura<T> AND Art.Estatus = <T>ALTA<T>
[Lista.Art.Articulo]
Carpeta=Lista
Clave=Art.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[Lista.Art.Unidad]
Carpeta=Lista
Clave=Art.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.CB.Codigo]
Carpeta=Lista
Clave=CB.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


[Lista.CB.Unidad]
Carpeta=Lista
Clave=CB.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



[Lista.Columnas]
Articulo=131
Descripcion1=350

Codigo=184
Unidad=122
Unidad_1=304
[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreDesplegar=&Seleccionar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Seleccionar/Aceptar
Visible=S
Activo=S
NombreEnBoton=S
EnBarraHerramientas=S

Antes=S
AntesExpresiones=Asigna(Info.Codigo,POSArt:CB.Codigo)
[Acciones.Info]
Nombre=Info
Boton=34
NombreEnBoton=S
NombreDesplegar=&Infomación
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=POSArtInfo
Visible=S
Antes=S

ActivoCondicion=Pos.WebService
AntesExpresiones=Asigna(Info.Articulo, POSArt:Art.Articulo)<BR>Asigna(Info.ArtTipo,POSArt:Art.Tipo)
[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Actualizar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Todo]
Nombre=Todo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Quitar]
Nombre=Quitar
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S












[Lista.POSArtCB.Codigo]
Carpeta=Lista
Clave=POSArtCB.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco























[Lista.POSArtCB.Unidad]
Carpeta=Lista
Clave=POSArtCB.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


















[Lista.ListaEnCaptura]
(Inicio)=CB.Codigo
CB.Codigo=Art.Articulo
Art.Articulo=Art.Descripcion1
Art.Descripcion1=CB.Unidad
CB.Unidad=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PROTOTIPO
PROTOTIPO=ALTA
ALTA=BLOQUEADO
BLOQUEADO=DESCONTINUADO
DESCONTINUADO=BAJA
BAJA=(Fin)

[Lista.ListaAcciones]
(Inicio)=Actualizar
Actualizar=Todo
Todo=Quitar
Quitar=(Fin)













[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Info
Info=(Fin)
