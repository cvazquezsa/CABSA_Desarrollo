[Forma]
Clave=ArtPrecioCategoria
Nombre=Modificar Precios
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.ArtCat, Sucursal.ListaPreciosEsp)
PosicionInicialIzquierda=246
PosicionInicialArriba=63
PosicionInicialAltura=410
PosicionInicialAncho=531
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialAlturaCliente=495

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
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
HojaVistaOmision=Automática
CampoColorLetras=Gris
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
CondicionEdicion=no General.PC
FiltroGeneral=ArtPrecioCostoMoneda.Categoria=<T>{Info.ArtCat}<T> AND<BR>ListaPreciosD.Lista=<T>{Sucursal.ListaPreciosEsp}<T>

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
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S

[Lista.Columnas]
Articulo=120
Descripcion1=184
SubCuenta=108
Precio=99
Moneda=84
Lista=140
MargenPromedio=87
PreciosNetos=69

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

[Acciones.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=36
NombreEnBoton=S
NombreDesplegar=Cancelar Cambios
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
VisibleCondicion=no General.PC

[Lista.ListaPreciosD.Moneda]
Carpeta=Lista
Clave=ListaPreciosD.Moneda
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.NivelUnidad]
Nombre=NivelUnidad
Boton=47
NombreEnBoton=S
NombreDesplegar=Nivel &Unidad
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ListaPreciosDUnidad
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Lista, ListaPreciosD:ListaPreciosD.Lista)
VisibleCondicion=Config.MultiUnidades y Config.PrecioNivelUnidad

[Lista.ListaPreciosD.Articulo]
Carpeta=Lista
Clave=ListaPreciosD.Articulo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Gris

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

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=NivelUnidad
NivelUnidad=Cancelar Cambios
Cancelar Cambios=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ListaPreciosD.Articulo
ListaPreciosD.Articulo=ArtPrecioCostoMoneda.Descripcion1
ArtPrecioCostoMoneda.Descripcion1=ListaPreciosD.Precio
ListaPreciosD.Precio=ListaPreciosD.Moneda
ListaPreciosD.Moneda=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=ArtPrecioCostoMoneda.PrecioLista
ArtPrecioCostoMoneda.PrecioLista=ArtPrecioCostoMoneda.MonedaPrecio
ArtPrecioCostoMoneda.MonedaPrecio=(Fin)
