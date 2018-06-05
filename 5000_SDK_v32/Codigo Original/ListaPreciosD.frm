[Forma]
Clave=ListaPreciosD
Nombre=Lista Precios Específicos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Lista, Info.Moneda)
PosicionInicialIzquierda=246
PosicionInicialArriba=167
PosicionInicialAltura=413
PosicionInicialAncho=820
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialAlturaCliente=386

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
FiltroTipo=Múltiple (por Grupos)
CondicionEdicion=no General.PC
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtFam
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=Fabricante
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=ArtLinea
FiltroAplicaEn1=ArtPrecioCostoMoneda.Categoria
FiltroAplicaEn2=ArtPrecioCostoMoneda.Grupo
FiltroAplicaEn3=ArtPrecioCostoMoneda.Familia
FiltroAplicaEn4=ArtPrecioCostoMoneda.Fabricante
FiltroAplicaEn5=ArtPrecioCostoMoneda.Linea
FiltroTodo=S
FiltroListasRama=INV
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
HojaMantenerSeleccion=S

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

[Lista.ListaPreciosD.Precio]
Carpeta=Lista
Clave=ListaPreciosD.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

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
Descripcion1=244
Precio=83
Moneda=54
CostoPromedio=84
UltimoCosto=82
MargenPromedio=91
CodigoCliente=110
Margen=55


Descripcion1_1=184
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
NombreDesplegar=&Precios
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

[Lista.ArtPrecioCostoMoneda.CostoPromedio]
Carpeta=Lista
Clave=ArtPrecioCostoMoneda.CostoPromedio
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Lista.ArtPrecioCostoMoneda.UltimoCosto]
Carpeta=Lista
Clave=ArtPrecioCostoMoneda.UltimoCosto
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Lista.MargenPromedio]
Carpeta=Lista
Clave=MargenPromedio
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Lista.ListaPreciosD.CodigoCliente]
Carpeta=Lista
Clave=ListaPreciosD.CodigoCliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.NivelOpcion]
Nombre=NivelOpcion
Boton=47
NombreEnBoton=S
NombreDesplegar=Precios a Nivel &Opción
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ListaPreciosSub
Antes=S
Visible=S
ActivoCondicion=ListaPreciosD:ArtPrecioCostoMoneda.TipoOpcion=TipoSi
AntesExpresiones=Asigna(Info.Articulo, ListaPreciosD:ListaPreciosD.Articulo)<BR>Asigna(Info.Descripcion, ListaPreciosD:ArtPrecioCostoMoneda.Descripcion1)

[Acciones.Explorar]
Nombre=Explorar
Boton=51
NombreDesplegar=Explorar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ExplorarListaPreciosD
Activo=S
Visible=S
GuardarAntes=S

[Lista.ListaPreciosD.Margen]
Carpeta=Lista
Clave=ListaPreciosD.Margen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.NivelUnidad]
Nombre=NivelUnidad
Boton=47
NombreEnBoton=S
NombreDesplegar=Nivel &Unidad
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ListaPreciosDUnidad
ConCondicion=S
Antes=S
Visible=S
ActivoCondicion=Config.MultiUnidades y Config.PrecioNivelUnidad
EjecucionCondicion=ConDatos(ListaPreciosD:ListaPreciosD.Articulo)
AntesExpresiones=Asigna(Info.Articulo, ListaPreciosD:ListaPreciosD.Articulo)<BR>Asigna(Info.Descripcion, ListaPreciosD:ArtPrecioCostoMoneda.Descripcion1)


[Lista.ListaEnCaptura]
(Inicio)=ListaPreciosD.Articulo
ListaPreciosD.Articulo=Art.Descripcion1
Art.Descripcion1=ListaPreciosD.CodigoCliente
ListaPreciosD.CodigoCliente=ListaPreciosD.Margen
ListaPreciosD.Margen=ListaPreciosD.Precio
ListaPreciosD.Precio=ArtPrecioCostoMoneda.CostoPromedio
ArtPrecioCostoMoneda.CostoPromedio=ArtPrecioCostoMoneda.UltimoCosto
ArtPrecioCostoMoneda.UltimoCosto=MargenPromedio
MargenPromedio=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=ArtPrecioCostoMoneda.PrecioLista
ArtPrecioCostoMoneda.PrecioLista=ArtPrecioCostoMoneda.MonedaPrecio
ArtPrecioCostoMoneda.MonedaPrecio=(Fin)

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Asistente
Asistente=Cancelar Cambios
Cancelar Cambios=NivelUnidad
NivelUnidad=NivelOpcion
NivelOpcion=Explorar
Explorar=(Fin)
