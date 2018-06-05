[Forma]
Clave=ListaPreciosDUnidad
Nombre=<T>Precios a Nivel Unidad - <T>+Info.Articulo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=451
PosicionInicialArriba=320
PosicionInicialAlturaCliente=350
PosicionInicialAncho=377
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Descripcion
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ListaPreciosDUnidad
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
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=ListaPreciosDUnidad.Lista=<T>{Info.Lista}<T> AND <BR>ListaPreciosDUnidad.Moneda=<T>{Info.Moneda}<T> AND<BR>ListaPreciosDUnidad.Articulo=<T>{Info.Articulo}<T>

[Lista.ListaPreciosDUnidad.Unidad]
Carpeta=Lista
Clave=ListaPreciosDUnidad.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaPreciosDUnidad.Precio]
Carpeta=Lista
Clave=ListaPreciosDUnidad.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Unidad=123
Precio=130

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=ListaPreciosDUnidad.Unidad
ListaPreciosDUnidad.Unidad=ListaPreciosDUnidad.Precio
ListaPreciosDUnidad.Precio=(Fin)
