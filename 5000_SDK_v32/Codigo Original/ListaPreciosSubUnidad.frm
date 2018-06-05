[Forma]
Clave=ListaPreciosSubUnidad
Nombre=<T>Precios a Nivel Unidad - <T>+Info.SubCuenta
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=355
PosicionInicialArriba=192
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
Vista=ListaPreciosSubUnidad
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
FiltroGeneral=ListaPreciosSubUnidad.Lista=<T>{Info.Lista}<T> AND <BR>ListaPreciosSubUnidad.Moneda=<T>{Info.Moneda}<T> AND<BR>ListaPreciosSubUnidad.Articulo=<T>{Info.Articulo}<T> AND<BR>ListaPreciosSubUnidad.SubCuenta=<T>{Info.SubCuenta}<T>

[Lista.ListaPreciosSubUnidad.Unidad]
Carpeta=Lista
Clave=ListaPreciosSubUnidad.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaPreciosSubUnidad.Precio]
Carpeta=Lista
Clave=ListaPreciosSubUnidad.Precio
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
(Inicio)=ListaPreciosSubUnidad.Unidad
ListaPreciosSubUnidad.Unidad=ListaPreciosSubUnidad.Precio
ListaPreciosSubUnidad.Precio=(Fin)
