[Forma]
Clave=ArtConDisponible
Nombre=<T>Existencias Disponibles<T>
Icono=44
Modulos=INV
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=310
PosicionInicialArriba=163
PosicionInicialAltura=465
PosicionInicialAncho=808
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaEscCerrar=S
BarraHerramientas=S
Comentarios=e(<T>Almac�n<T>)+<T>: <T>+Si(ConDatos(Info.Almacen), Info.Almacen, <T>(Todos)<T>)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=438
MovModulo=INV

[ArtDisponible]
Estilo=Hoja
Pestana=
Clave=ArtDisponible
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtDisponible
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

[ArtDisponible.Columnas]
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

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreDesplegar=&Seleccionar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Visible=S
Activo=S
NombreEnBoton=S
EnBarraHerramientas=S

[ArtDisponible.Disponible]
Carpeta=ArtDisponible
Clave=Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[ArtDisponible.Articulo]
Carpeta=ArtDisponible
Clave=Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S

[ArtDisponible.Descripcion1]
Carpeta=ArtDisponible
Clave=Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S

[ArtDisponible.PrecioLista]
Carpeta=ArtDisponible
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
Vista=ArtConDisponible
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
FiltroTipo=M�ltiple (por Grupos)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroTodoFinal=S
FiltroNullNombre=(sin clategor�a)
FiltroRespetar=S
FiltroAplicaEn1=Art.Categoria
FiltroListas=S
FiltroListasRama=INV
FiltroListasAplicaEn=Art.Articulo
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtFam
FiltroAplicaEn2=Art.Familia
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtGrupo
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=ArtLinea
FiltroAplicaEn3=Art.Grupo
FiltroAplicaEn4=Art.Linea
OtroOrden=S
ListaOrden=Art.Articulo<TAB>(Acendente)
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
IconosCampo=Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Art�culo<T>
ElementosPorPagina=200
PermiteLocalizar=S
PestanaNombre=Art�culos
FiltroEstatus=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
FiltroSituacion=S
FiltroSituacionTodo=S
BusquedaRespetarControles=S
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=Fabricante
FiltroAplicaEn5=Art.Fabricante
IconosNombre=ArtConDisponible:Art.Articulo
[Lista.Columnas]
Articulo=92
Descripcion1=224
PrecioLista=71
Disponible=57
Tipo=46
0=127
1=211
EstatusNombre=77

2=-2
3=-2
[Acciones.Info]
Nombre=Info
Boton=34
NombreEnBoton=S
NombreDesplegar=&Infomaci�n
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Asigna( Info.Articulo,ArtConDisponible:Art.Articulo )<BR>Asigna( Info.ArtTipo, ArtConDisponible:Tipo )

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

[Lista.Descripcion1]
Carpeta=Lista
Clave=Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.PrecioLista]
Carpeta=Lista
Clave=PrecioLista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Disponible]
Carpeta=Lista
Clave=Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

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

[Acciones.SeleccionarTodo]
Nombre=SeleccionarTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
VisibleCondicion=FormaSeleccion

[Acciones.Todo]
Nombre=Todo
Boton=55
NombreEnBoton=S
NombreDesplegar=&Ver Todos Almacenes
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Antes=S
EspacioPrevio=S
Visible=S
ActivoCondicion=ConDatos(Info.Almacen)
AntesExpresiones=Asigna(Info.Almacen, Nulo)

[Acciones.QuitarSeleccion]
Nombre=QuitarSeleccion
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
VisibleCondicion=FormaSeleccion

[Acciones.Unidades]
Nombre=Unidades
Boton=65
NombreEnBoton=S
NombreDesplegar=&Unidades
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtUnidadDisponible
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ArtConDisponible:Art.Articulo)
AntesExpresiones=Asigna(Info.Articulo, ArtConDisponible:Art.Articulo)<BR>Asigna(Info.Disponible, ArtConDisponible:Disponible)


[ArtDisponible.ListaEnCaptura]
(Inicio)=Articulo
Articulo=Descripcion1
Descripcion1=PrecioLista
PrecioLista=Disponible
Disponible=(Fin)








[Lista.ListaEnCaptura]
(Inicio)=Descripcion1
Descripcion1=PrecioLista
PrecioLista=Disponible
Disponible=Almacen
Almacen=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PROTOTIPO
PROTOTIPO=ALTA
ALTA=BLOQUEADO
BLOQUEADO=DESCONTINUADO
DESCONTINUADO=BAJA
BAJA=(Fin)

[Lista.ListaAcciones]
(Inicio)=SeleccionarTodo
SeleccionarTodo=QuitarSeleccion
QuitarSeleccion=(Fin)

[Lista.Almacen]
Carpeta=Lista
Clave=Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Info
Info=Unidades
Unidades=Todo
Todo=Campos
Campos=(Fin)
