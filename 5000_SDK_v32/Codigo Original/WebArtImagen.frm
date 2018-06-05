
[Forma]
Clave=WebArtImagen
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=WebArtImagen

ListaCarpetas=WebArtImagen
Nombre=Imágenes Artículos eCommerce
PosicionInicialIzquierda=441
PosicionInicialArriba=131
PosicionInicialAlturaCliente=559
PosicionInicialAncho=708
PosicionCol1=286
PosicionSec1=303
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
BarraHerramientas=S
Comentarios=Info.Articulo
Menus=S
MenuPrincipal=&Edición
[WebArtImagen]
Estilo=Hoja
Clave=WebArtImagen
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtImagen
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
ListaEnCaptura=WebArtImagen.Nombre<BR>WebArtImagen.ArchivoImagen
CarpetaVisible=S

Filtros=S
OtroOrden=S
ListaOrden=WebArtImagen.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaIndicador=S
PermiteEditar=S
FiltroGeneral=WebArtImagen.IDArt = {Info.ID}
[WebArtImagen.WebArtImagen.ArchivoImagen]
Carpeta=WebArtImagen
Clave=WebArtImagen.ArchivoImagen
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco


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

AntesExpresiones=FormaModal(<T>WebARtImagenOrdenar<T>)
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
Expresion=FormaModal(<T>WebArtImagenTemp<T>)<BR>ActualizarForma
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
TeclaRapida=Shift+Ctrl+I
EnMenu=S
Menu=&Edición
EsDefault=S
[WebArtImagen.WebArtImagen.Nombre]
Carpeta=WebArtImagen
Clave=WebArtImagen.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Registro Eliminar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Archivo.Eliminar(WebArtImagen:WebArtImagen.ArchivoImagen )
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
Expresion=VerImagen(WebArtImagen:WebArtImagen.Nombre,WebArtImagen:WebArtImagen.ArchivoImagen)











[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Registro Eliminar
Registro Eliminar=Orden
Orden=Preliminar
Preliminar=(Fin)
