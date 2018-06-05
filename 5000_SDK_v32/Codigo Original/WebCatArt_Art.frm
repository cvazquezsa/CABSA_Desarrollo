
[Forma]
Clave=WebCatArt_Art
Icono=0
Modulos=(Todos)
Nombre=Categorías  Artículos eCommerce 
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=WebCatArt_Art
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=WebCatArt_Art
Comentarios=Info.Articulo
ListaAcciones=(Lista)
PosicionInicialIzquierda=531
PosicionInicialArriba=294
PosicionInicialAlturaCliente=273
PosicionInicialAncho=538
ExpresionesAlCerrar=EjecutarSQL(<T>spWebArtCategoias :nID<T>,Info.ID)
SinTransacciones=S
[WebCatArt_Art]
Estilo=Hoja
Clave=WebCatArt_Art
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebCatArt_Art
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
ListaEnCaptura=WebCatArt_Art.Nombre
CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral=WebCatArt_Art.IDWebArt = {Info.ID}
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[WebCatArt_Art.Columnas]
IDWebCatArt=89
Nombre_1=304

NombreCategoria=304
Nombre=500
[Lista.Columnas]
Nombre=231





0=180
1=-2
[WebCatArt_Art.WebCatArt_Art.Nombre]
Carpeta=WebCatArt_Art
Clave=WebCatArt_Art.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



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
Expresion=FormaModal(<T>WebCatArtLista2<T>)<BR>ActualizarForma
[Acciones.Registro Eliminar]
Nombre=Registro Eliminar
Boton=63
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
EspacioPrevio=S
NombreEnBoton=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Registro Eliminar
Registro Eliminar=(Fin)
