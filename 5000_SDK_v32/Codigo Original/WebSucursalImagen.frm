
[Forma]
Clave=WebSucursalImagen
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=WebSucursalImagen

ListaCarpetas=WebSucursalImagen
Nombre=Imágenes Tiendas eCommerce
PosicionInicialIzquierda=361
PosicionInicialArriba=151
PosicionInicialAlturaCliente=559
PosicionInicialAncho=877
PosicionCol1=286
PosicionSec1=303
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
BarraHerramientas=S
Comentarios=Info.Sucursal
Menus=S
PosicionSeccion1=50


MenuPrincipal=&Edición
[Ficha.WebArtImagen.ArchivoImagen]
Carpeta=Ficha
Clave=WebArtImagen.ArchivoImagen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[WebArtImagen.Columnas]
ArchivoImagen=495

Descripcion=304

Nombre=158
[Descripcion.WebArtImagen.Descripcion]
Carpeta=Descripcion
Clave=WebArtImagen.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

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

AntesExpresiones=FormaModal(<T>WebSucursalImagenOrdenar<T>)
[Lista.Columnas]
0=49
1=434


[Acciones.Nuevo]
Nombre=Nuevo
Boton=62
NombreDesplegar=&Agregar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S

NombreEnBoton=S
EspacioPrevio=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
EnMenu=S
Menu=&Edición
EsDefault=S
Expresion=FormaModal(<T>WebSucursalImagenTemp<T>)<BR>ActualizarForma
[Acciones.Registro Eliminar]
Nombre=Registro Eliminar
Boton=63
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
NombreEnBoton=S



Multiple=S
ListaAccionesMultiples=Expresion<BR>Registro Eliminar
UsaTeclaRapida=S
EnMenu=S
Menu=&Edición
EsDefault=S

[Acciones.Registro Eliminar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Archivo.Eliminar(WebSucursalImagen:WebSucursalImagen.ArchivoImagen)

[Acciones.Registro Eliminar.Registro Eliminar]
Nombre=Registro Eliminar
Boton=0
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=&Preliminar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
NombreEnBoton=S
EspacioPrevio=S
Expresion=VerImagen(WebSucursalImagen:WebSucursalImagen.Nombre,WebSucursalImagen:WebSucursalImagen.ArchivoImagen)
[WebSucursalImagen]
Estilo=Hoja
Clave=WebSucursalImagen
Filtros=S
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebSucursalImagen
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaIndicador=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=WebSucursalImagen.Nombre<BR>WebSucursalImagen.ArchivoImagen<BR>WebSucursalImagen.Liga
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
ListaOrden=WebSucursalImagen.Orden<TAB>(Acendente)
HojaMantenerSeleccion=S
FiltroGeneral=WebSucursalImagen.Sucursal = {Info.Sucursal}
[WebSucursalImagen.WebSucursalImagen.Nombre]
Carpeta=WebSucursalImagen
Clave=WebSucursalImagen.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
[WebSucursalImagen.WebSucursalImagen.ArchivoImagen]
Carpeta=WebSucursalImagen
Clave=WebSucursalImagen.ArchivoImagen
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro
[WebSucursalImagen.Columnas]
Nombre=304
ArchivoImagen=326
Descripcion=604
Liga=494
[Descripcion.WebSucursalImagen.Descripcion]
Carpeta=Descripcion
Clave=WebSucursalImagen.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5x10
ColorFondo=Blanco
ColorFuente=Negro
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar
GuardarAntes=S
EnBarraHerramientas=S
EnBarraAcciones=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
[WebSucursalImagen.WebSucursalImagen.Liga]
Carpeta=WebSucursalImagen
Clave=WebSucursalImagen.Liga
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro
[Acciones.WebSucursalImagenDescripcion]
Nombre=WebSucursalImagenDescripcion
Boton=55
NombreDesplegar=&Descripción
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=WebSucursalImagenDescripcion
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
NombreEnBoton=S
AntesExpresiones=Asigna(Info.Nombre,WebSucursalImagen:WebSucursalImagen.Nombre)





[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=WebSucursalImagenDescripcion
WebSucursalImagenDescripcion=Nuevo
Nuevo=Registro Eliminar
Registro Eliminar=Orden
Orden=Preliminar
Preliminar=(Fin)
