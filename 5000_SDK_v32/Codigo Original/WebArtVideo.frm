

[Forma]
Clave=WebArtVideo
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=WebArtVideo

ListaCarpetas=(Lista)
Nombre=Videos Artículos eCommerce
PosicionInicialIzquierda=387
PosicionInicialArriba=192
PosicionInicialAlturaCliente=437
PosicionInicialAncho=816
PosicionCol1=326
PosicionSec1=270
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
BarraHerramientas=S
Comentarios=Info.Articulo
[WebArtVideo]
Estilo=Hoja
Clave=WebArtVideo
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtVideo
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
ListaEnCaptura=WebArtVideo.Ubicacion<BR>WebArtVideo.Titulo
CarpetaVisible=S

Filtros=S
OtroOrden=S
ListaOrden=WebArtVideo.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General


PermiteEditar=S
FiltroGeneral=WebArtVideo.IDArt = {Info.ID}
[WebArtVideo.Columnas]
ArchivoImagen=252

Titulo=294
Ubicacion=472
Duracion=64
[Descripcion]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Descripción
Clave=Descripcion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtVideo
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=WebArtVideo.Descripcion
CarpetaVisible=S

AlinearTodaCarpeta=S
Pestana=S
FichaMarco=S
CarpetaDesActivada=S
[Descripcion.WebArtVideo.Descripcion]
Carpeta=Descripcion
Clave=WebArtVideo.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

EnBarraHerramientas=S
NombreEnBoton=S
[Acciones.Registro Insertar]
Nombre=Registro Insertar
Boton=1
NombreDesplegar=&Nuevo
EnBarraAcciones=S
EspacioPrevio=S
Carpeta=Ficha
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S

EnBarraHerramientas=S
NombreEnBoton=S
[Acciones.Registro Eliminar]
Nombre=Registro Eliminar
Boton=5
NombreDesplegar=& Eliminar
EnBarraAcciones=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
EnBarraHerramientas=S
NombreEnBoton=S


[Acciones.Orden]
Nombre=Orden
Boton=50
NombreEnBoton=S
NombreDesplegar=Cambiar &Orden
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
Visible=S

AntesExpresiones=FormaModal(<T>WebArtVideoOrdenar<T>)
[Lista.Columnas]
0=49
1=434

[WebArtVideo.WebArtVideo.Titulo]
Carpeta=WebArtVideo
Clave=WebArtVideo.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Ficha.WebArtVideo.Titulo]
Carpeta=Ficha
Clave=WebArtVideo.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[Ficha.WebArtVideo.Duracion]
Carpeta=Ficha
Clave=WebArtVideo.Duracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Ficha.WebArtVideo.Ubicacion]
Carpeta=Ficha
Clave=WebArtVideo.Ubicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[WebArtVideo.WebArtVideo.Ubicacion]
Carpeta=WebArtVideo
Clave=WebArtVideo.Ubicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco













[Forma.ListaCarpetas]
(Inicio)=WebArtVideo
WebArtVideo=Descripcion
Descripcion=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Registro Insertar
Registro Insertar=Registro Eliminar
Registro Eliminar=Orden
Orden=(Fin)
