[Forma]
Clave=ArtCostoLista
Nombre=Artículos
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=121
PosicionInicialArriba=146
PosicionInicialAltura=476
PosicionInicialAncho=781
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=Asigna( Info.Articulo, Nulo )
ExpresionesAlCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtConCosto
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
HojaPermiteInsertar=S
Filtros=S
FiltroTipo=Múltiple (por Grupos)
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=20
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=ArtFam
BusquedaRapidaControles=S
FiltroAplicaEn=Art.Familia
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroTodo=S
FiltroTodoFinal=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtFam
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtGrupo
FiltroAplicaEn1=Art.Categoria
FiltroAplicaEn2=Art.Familia
FiltroListas=S
FiltroListasRama=INV
FiltroListasAplicaEn=Art.Articulo
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=Fabricante
FiltroAplicaEn3=Art.Grupo
FiltroAplicaEn4=Art.Fabricante
PermiteLocalizar=S
HojaAjustarColumnas=S
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
FiltroGeneral=ArtCosto.Sucursal={Sucursal} AND ArtCosto.Empresa=<T>{Empresa}<T> AND Art.Tipo<><T>Estructura<T>

[Lista.ArtCosto.UltimoCosto]
Carpeta=Lista
Clave=ArtCosto.UltimoCosto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFuente=Negro
ColorFondo=Blanco
Editar=S

[Lista.Columnas]
Articulo=109
Descripcion1=126
PrecioLista=74
UltimoCosto=74
CostoPromedio=80
CostoEstandar=81
SubCuenta=64
CostoReposicion=86

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

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

[Lista.Art.PrecioLista]
Carpeta=Lista
Clave=Art.PrecioLista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
NombreDesplegar=&Información
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
NombreEnBoton=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(ArtConCosto:Art.Articulo)
AntesExpresiones=Asigna(Info.Articulo, ArtConCosto:Art.Articulo)<BR>Asigna(Info.Origen, <T>COMS<T>)

[Lista.Art.Articulo]
Carpeta=Lista
Clave=Art.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.CostoEstandar]
Carpeta=Lista
Clave=Art.CostoEstandar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.CostoReposicion]
Carpeta=Lista
Clave=Art.CostoReposicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=ArtInfo
ArtInfo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Art.Articulo
Art.Articulo=Art.Descripcion1
Art.Descripcion1=Art.PrecioLista
Art.PrecioLista=ArtCosto.UltimoCosto
ArtCosto.UltimoCosto=Art.CostoEstandar
Art.CostoEstandar=Art.CostoReposicion
Art.CostoReposicion=(Fin)
