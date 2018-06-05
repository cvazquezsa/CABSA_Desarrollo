[Forma]
Clave=ListaPreciosDInfo
Nombre=Lista Precios Específicos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Lista, Info.Moneda)
PosicionInicialIzquierda=216
PosicionInicialArriba=179
PosicionInicialAltura=413
PosicionInicialAncho=591
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ListaPreciosD
Fuente={MS Sans Serif, 8, Negro, []}
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
ValidarCampos=S
ListaCamposAValidar=(Lista)
HojaIndicador=S
HojaAjustarColumnas=S
OtroOrden=S
ListaOrden=ListaPreciosD.Articulo<TAB>(Acendente)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=ListaPreciosD.Lista=<T>{Info.Lista}<T> AND ListaPreciosD.Moneda=<T>{Info.Moneda}<T>

[Lista.ListaPreciosD.Articulo]
Carpeta=Lista
Clave=ListaPreciosD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaPreciosD.Precio]
Carpeta=Lista
Clave=ListaPreciosD.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Articulo=120
Descripcion1=221
SubCuenta=108
Precio=83
Moneda=54
CostoPromedio=84
UltimoCosto=82
MargenPromedio=91
CodigoCliente=124

[Lista.ArtPrecioCostoMoneda.Descripcion1]
Carpeta=Lista
Clave=ArtPrecioCostoMoneda.Descripcion1
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Lista.ListaPreciosD.CodigoCliente]
Carpeta=Lista
Clave=ListaPreciosD.CodigoCliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=ListaPreciosD.Articulo
ListaPreciosD.Articulo=ArtPrecioCostoMoneda.Descripcion1
ArtPrecioCostoMoneda.Descripcion1=ListaPreciosD.CodigoCliente
ListaPreciosD.CodigoCliente=ListaPreciosD.Precio
ListaPreciosD.Precio=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=ArtPrecioCostoMoneda.PrecioLista
ArtPrecioCostoMoneda.PrecioLista=ArtPrecioCostoMoneda.MonedaPrecio
ArtPrecioCostoMoneda.MonedaPrecio=(Fin)
