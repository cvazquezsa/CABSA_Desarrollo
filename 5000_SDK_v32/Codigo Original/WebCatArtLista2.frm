[Forma]
Clave=WebCatArtLista2
Nombre=Categorías de Artículos eCommerce
Icono=0
Modulos=(Todos)
AccionesTamanoBoton=14x5
AccionesDerecha=S
PosicionInicialIzquierda=533
PosicionInicialArriba=242
PosicionInicialAltura=345
PosicionInicialAncho=533
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
PosicionInicialAlturaCliente=377

PosicionCol1=511
Menus=S
ListaCarpetas=(Lista)
CarpetaPrincipal=WebCatArt
VentanaEstadoInicial=Normal
PosicionSec1=136
ExpresionesAlMostrar=EjecutarSQL(<T>spWebArtBorrarWebCatArtTemp :Estacion<T>,EstacionTrabajo)
[ArtCat.Columnas]
Categoria=104
Descripcion=304


[Lista.Columnas]
Categoria=234
Descripcion=325

Nombre=231
0=180
1=-2
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
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
EnBarraAcciones=S
TipoAccion=Expresion
Activo=S
Visible=S

GuardarAntes=S





Multiple=S
ListaAccionesMultiples=Insertar<BR>Cerrar
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


0=-2
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

[Lista.WebCatArt.Nombre]
Carpeta=Lista
Clave=WebCatArt.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[WebCatArt]
Estilo=Hoja
Clave=WebCatArt
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebCatArt
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=WebCatArt.Nombre
CarpetaVisible=S

Filtros=S
OtroOrden=S
ListaOrden=WebCatArt.Orden<TAB>(Acendente)
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
[WebCatArt.WebCatArt.Nombre]
Carpeta=WebCatArt
Clave=WebCatArt.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[WebCatArt.Columnas]
Nombre=337

[Acciones.Seleccionar.Insertar]
Nombre=Insertar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>spWebArtInsertarWebCatArt_Art3 :nEstacion,:nIdArt<T>,EstacionTrabajo,Info.ID)
[Acciones.Seleccionar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Seleccionar2]
Nombre=Seleccionar2
Boton=54
NombreEnBoton=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+S
EsDefault=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>spWebArtInsertarWebCatArt_Art2 :nEstacion, :nIDArt,:nIDCat<T>,EstacionTrabajo,Info.ID,WebCatArt:WebCatArt.ID)<BR>ActualizarForma
[WebCatArtTemp]
Estilo=Iconos
Clave=WebCatArtTemp
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=WebCatArtTemp
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosNombre=WebCatArtTemp:WebCatArtTemp.Nombre
IconosSubTitulo=<T>Nombre<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Negro
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=WebCatArtTemp.Estacion = {EstacionTrabajo}
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[Forma.ListaCarpetas]
(Inicio)=WebCatArt
WebCatArt=WebCatArtTemp
WebCatArtTemp=(Fin)

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Seleccionar2
Seleccionar2=(Fin)
