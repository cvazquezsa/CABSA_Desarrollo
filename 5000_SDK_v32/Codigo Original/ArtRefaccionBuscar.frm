[Forma]
Clave=ArtRefaccionBuscar
Nombre=Buscar Refacciones
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=148
PosicionInicialArriba=250
PosicionInicialAltura=268
PosicionInicialAncho=728
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtRefaccion
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=30
BusquedaEnLinea=S
CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Refacción<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Refacciones
BusquedaRespetarFiltros=
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Predefinido
FiltroPredefinido1=Indique el artículo a buscar
FiltroPredefinido2=ArtRefaccion.Articulo=NULL
FiltroPredefinido3=ArtRefaccion.Refaccion
IconosNombre=ArtRefaccion:ArtRefaccion.Refaccion
FiltroEstilo=Folder (1 línea)

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100

[Lista.ArtRefaccion.Cantidad]
Carpeta=Lista
Clave=ArtRefaccion.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S

[Lista.Columnas]
Refaccion=124
Descripcion1=244
Cantidad=64
0=97
1=207

[Lista.Art.Categoria]
Carpeta=Lista
Clave=Art.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Lista.Art.Grupo]
Carpeta=Lista
Clave=Art.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Lista.Art.Familia]
Carpeta=Lista
Clave=Art.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Lista.Art.Fabricante]
Carpeta=Lista
Clave=Art.Fabricante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=ArtRefaccion.Cantidad
ArtRefaccion.Cantidad=Art.Categoria
Art.Categoria=Art.Grupo
Art.Grupo=Art.Familia
Art.Familia=Art.Fabricante
Art.Fabricante=(Fin)
