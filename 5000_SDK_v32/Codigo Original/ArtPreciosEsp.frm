[Forma]
Clave=ArtPreciosEsp
Nombre=Precios Específicos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Articulo, Info.Descripcion)
PosicionInicialIzquierda=207
PosicionInicialArriba=175
PosicionInicialAltura=410
PosicionInicialAncho=609
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialAlturaCliente=383

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
FiltroGeneral=ListaPreciosD.Articulo=<T>{Info.Articulo}<T>

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
Moneda=54
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

[Acciones.Asistente]
Nombre=Asistente
Boton=12
NombreEnBoton=S
NombreDesplegar=&Asistente
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Wizards
ClaveAccion=Asistente Lista Precios
ListaParametros1=ListaPreciosD:ArtPrecioCostoMoneda.PrecioLista<BR>ListaPreciosD:ArtPrecioCostoMoneda.Precio2<BR>ListaPreciosD:ArtPrecioCostoMoneda.Precio3<BR>ListaPreciosD:ArtPrecioCostoMoneda.Precio4<BR>ListaPreciosD:ArtPrecioCostoMoneda.Precio5<BR>ListaPreciosD:ArtPrecioCostoMoneda.Precio6<BR>ListaPreciosD:ArtPrecioCostoMoneda.Precio7<BR>ListaPreciosD:ArtPrecioCostoMoneda.Precio8<BR>ListaPreciosD:ArtPrecioCostoMoneda.Precio9<BR>ListaPreciosD:ArtPrecioCostoMoneda.Precio10<BR>ListaPreciosD:ArtPrecioCostoMoneda.PrecioMinimo<BR>ListaPreciosD:ArtPrecioCostoMoneda.MargenMinimo<BR>ListaPreciosD:ArtPrecioCostoMoneda.Margen<BR>ListaPreciosD:ArtPrecioCostoMoneda.CostoEstandar<BR>ListaPreciosD:ArtPrecioCostoMoneda.CostoReposicion<BR>ListaPreciosD:ArtPrecioCostoMoneda.CostoPromedio<BR>ListaPreciosD:ArtPrecioCostoMoneda.UltimoCosto<BR>ListaPreciosD:ListaPreciosD.Precio<BR>ListaPreciosD:ArtPrecioCostoMoneda.TipoCambioPrecio<BR>ListaPreciosD:ArtPrecioCostoMoneda.TipoCambioCosto<BR>Info.TipoCambio
ListaParametros=S
Activo=S
VisibleCondicion=no General.PC

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

[Lista.ListaPreciosD.Lista]
Carpeta=Lista
Clave=ListaPreciosD.Lista
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Gris

[Lista.MargenPromedio]
Carpeta=Lista
Clave=MargenPromedio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Lista.ListaPrecios.PreciosNetos]
Carpeta=Lista
Clave=ListaPrecios.PreciosNetos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=NivelUnidad
NivelUnidad=Asistente
Asistente=Cancelar Cambios
Cancelar Cambios=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ListaPreciosD.Lista
ListaPreciosD.Lista=ListaPreciosD.Precio
ListaPreciosD.Precio=ListaPreciosD.Moneda
ListaPreciosD.Moneda=MargenPromedio
MargenPromedio=ListaPrecios.PreciosNetos
ListaPrecios.PreciosNetos=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=ArtPrecioCostoMoneda.PrecioLista
ArtPrecioCostoMoneda.PrecioLista=ArtPrecioCostoMoneda.MonedaPrecio
ArtPrecioCostoMoneda.MonedaPrecio=(Fin)
