[Forma]
Clave=ListaPreciosSub
Nombre=<T>Precios a Nivel Opción - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Lista, Info.Moneda, Info.Articulo)
PosicionInicialIzquierda=336
PosicionInicialArriba=271
PosicionInicialAltura=481
PosicionInicialAncho=608
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialAlturaCliente=454

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ListaPreciosSub
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
ListaOrden=ListaPreciosSub.SubCuenta<TAB>(Acendente)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CondicionEdicion=no General.PC
HojaMantenerSeleccion=S
FiltroGeneral=ListaPreciosSub.Lista=<T>{Info.Lista}<T> AND <BR>ListaPreciosSub.Moneda=<T>{Info.Moneda}<T> AND<BR>ListaPreciosSub.Articulo=<T>{Info.Articulo}<T>

[Lista.ListaPreciosSub.Precio]
Carpeta=Lista
Clave=ListaPreciosSub.Precio
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
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(ListaPreciosSub:ListaPreciosSub.SubCuenta)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Lista.Columnas]
Articulo=120
Descripcion1=166
Precio=112
Moneda=54
CostoPromedio=84
UltimoCosto=82
MargenPromedio=89
CodigoCliente=110
SubCuenta=124
OpcionDesc=329
CostoEstandar_1=78
CostoReposicion_1=86
CostoEstandar=78
CostoReposicion=86

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
EspacioPrevio=S
VisibleCondicion=no General.PC

[Lista.ListaPreciosSub.SubCuenta]
Carpeta=Lista
Clave=ListaPreciosSub.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OpcionDesc]
Carpeta=Lista
Clave=OpcionDesc
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.Opciones]
Nombre=Opciones
Boton=12
NombreEnBoton=S
NombreDesplegar=&Opciones
Multiple=S
EnBarraHerramientas=S
EspacioPrevio=S
Activo=S
Visible=S
ListaAccionesMultiples=Registro Agregar<BR>Asistente Articulos

[Acciones.Opciones.Registro Agregar]
Nombre=Registro Agregar
Boton=0
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Opciones.Asistente Articulos]
Nombre=Asistente Articulos
Boton=0
Carpeta=(Carpeta principal)
TipoAccion=Wizards
ClaveAccion=Asistente Articulos
ListaParametros1=ListaPreciosSub:ListaPreciosSub.Articulo<BR>Nulo<BR>ListaPreciosSub:ListaPreciosSub.SubCuenta<BR>ListaPreciosSub:ListaPreciosSub.Precio<BR>Nulo<BR>Nulo<BR>Nulo<BR>Nulo<BR>Nulo<BR>Nulo<BR>Nulo<BR>Nulo<BR>Nulo<BR><T>Si<T><BR>Falso<BR>Nulo<BR>Nulo<BR>Nulo<BR>Nulo<BR>Nulo<BR>Nulo
ListaParametros=S
Activo=S
Visible=S

[Acciones.NivelUnidad]
Nombre=NivelUnidad
Boton=47
NombreEnBoton=S
NombreDesplegar=Nivel &Unidad
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ListaPreciosSubUnidad
ConCondicion=S
Antes=S
Visible=S
ActivoCondicion=Config.MultiUnidades y Config.PrecioNivelUnidad
EjecucionCondicion=ConDatos(ListaPreciosSub:ListaPreciosSub.SubCuenta)
AntesExpresiones=Asigna(Info.SubCuenta, ListaPreciosSub:ListaPreciosSub.SubCuenta)<BR>Asigna(Info.Descripcion, ListaPreciosSub:OpcionDesc)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Opciones
Opciones=Cancelar Cambios
Cancelar Cambios=NivelUnidad
NivelUnidad=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ListaPreciosSub.SubCuenta
ListaPreciosSub.SubCuenta=OpcionDesc
OpcionDesc=ListaPreciosSub.Precio
ListaPreciosSub.Precio=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=Art.PrecioLista
Art.PrecioLista=(Fin)
