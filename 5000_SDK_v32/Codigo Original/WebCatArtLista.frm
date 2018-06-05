[Forma]
Clave=WebCatArtLista
Nombre=Categorías de Artículos eCommerce
Icono=0
Modulos=INV
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=Lista
PosicionInicialIzquierda=366
PosicionInicialArriba=262
PosicionInicialAltura=345
PosicionInicialAncho=997
CarpetaPrincipal=Lista
ListaAcciones=Seleccionar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
PosicionInicialAlturaCliente=338

PosicionCol1=511
[ArtCat.Columnas]
Categoria=104
Descripcion=304

[Lista]
Estilo=Iconos
PestanaNombre=Lista
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebCatArt
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaOrden=WebCatArt.Orden<TAB>(Acendente)
CarpetaVisible=S
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


ListaEnCaptura=WebCatArt.Descripcion
Filtros=S
FiltroPredefinido=S
FiltroArbolClave=WebCatArt.ID
FiltroArbolValidar=WebCatArt.Nombre
FiltroArbolRama=WebCatArt.Rama
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Arbol
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Nombre<T>
IconosSeleccionMultiple=S
ElementosPorPagina=200
IconosNombre=WebCatArt:WebCatArt.Nombre
[Lista.Columnas]
Categoria=234
Descripcion=325

Nombre=231
0=180
1=650
[Detalles.ArtCat.Categoria]
Carpeta=Detalles
Clave=ArtCat.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalles.ArtCat.Icono]
Carpeta=Detalles
Clave=ArtCat.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
EnMenu=S
EnBarraAcciones=S
TipoAccion=Expresion
Activo=S
Visible=S

GuardarAntes=S





Multiple=S
ListaAccionesMultiples=Expresion<BR>Aceptar
[WebCatArtTemp.WebCatArtTemp.Nombre]
Carpeta=WebCatArtTemp
Clave=WebCatArtTemp.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[WebCatArtTemp.Columnas]
Nombre=304

[Lista.WebCatArt.Descripcion]
Carpeta=Lista
Clave=WebCatArt.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Seleccionar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si<BR>  CuantosSeleccionID(<T>WebCatArtLista<T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>WebCatArtLista<T>)<BR>  EjecutarSQL(<T>spWebArtInsertarWebCatArt_Art :nEstacion, :nID<T>, EstacionTrabajo, Info.ID)<BR>  ActualizarForma<BR>Fin
[Acciones.Seleccionar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
