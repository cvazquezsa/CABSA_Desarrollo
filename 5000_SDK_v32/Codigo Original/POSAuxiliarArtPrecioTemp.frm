
[Forma]
Clave=POSAuxiliarArtPrecioTemp
Nombre=Herramienta Generar Etiquetas Art�culos Cambio Precios
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=306
PosicionInicialArriba=141
PosicionInicialAltura=425
PosicionInicialAncho=987
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
MovModulo=INV
PosicionInicialAlturaCliente=540

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
ExpresionesAlMostrar=EjecutarSQL(<T>spPOSBorrarPOSArtSucursalTemp :nEstacion<T>,EstacionTrabajo)
[Lista]
Estilo=Iconos
Clave=Lista
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSAuxiliarArtPrecioTemp
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=25
BusquedaEnLinea=S
CarpetaVisible=S
Filtros=S
FiltroGrupo1=(Validaciones Memoria)
FiltroPredefinido=S
FiltroAplicaEn=Art.Categoria
FiltroTipo=M�ltiple (por Grupos)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroTodoFinal=S
FiltroNullNombre=(sin familia)
FiltroRespetar=S
FiltroAncho=25
FiltroClase=S
FiltroClaseTodo=S
FiltroFechasNormal=S
FiltroListas=S
FiltroListasRama=INV
FiltroListasAplicaEn=Art.Articulo
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtFam
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=ArtLinea
FiltroAplicaEn2=Art.Grupo
FiltroAplicaEn3=Art.Familia
FiltroAplicaEn4=Art.Linea
MenuLocal=S
ListaAcciones=(Lista)
OtroOrden=S
ListaOrden=POSAuxiliarArtPrecioTemp.Codigo<TAB>(Acendente)
PermiteLocalizar=S
PestanaNombre=Art�culos
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=Fabricante
FiltroAplicaEn5=Art.Fabricante
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
FiltroSituacionTodo=S

IconosCampo=(por Omisi�n)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSeleccionMultiple=S
IconosSubTitulo=<T>C�digo<T>

PestanaOtroNombre=S

ListaEnCaptura=(Lista)
FiltroValida1=ArtCat
FiltroAplicaEn1=Art.Categoria
BusquedaRespetarFiltros=S
IconosNombre=POSAuxiliarArtPrecioTemp:POSAuxiliarArtPrecioTemp.Codigo
FiltroGeneral=POSAuxiliarArtPrecioTemp.Estacion = {EstacionTrabajo}
[Lista.Columnas]
Articulo=131
Descripcion1=244

0=80
1=191


2=190
3=-2
4=-2
5=78
6=-2
[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Actualizar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Todo]
Nombre=Todo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Quitar]
Nombre=Quitar
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S















[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



[POSArtSucursalTemp.Columnas]
Sucursal=64
Nombre=300






[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S






















































Expresion=RegistrarSeleccion(<T>POSAuxiliarArtPrecioTemp<T>)<BR>EjecutarSQL(<T>spPOSHerrEtiquetasCB :nEstacion<T>,EstacionTrabajo)<BR>FormaModal(<T>POSArtCBTemp<T>)
[POSArtCBTemp.Columnas]
Codigo=184
Articulo=124
Cantidad=64









































[Lista.POSAuxiliarArtPrecioTemp.Articulo]
Carpeta=Lista
Clave=POSAuxiliarArtPrecioTemp.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.POSAuxiliarArtPrecioTemp.SubCuenta]
Carpeta=Lista
Clave=POSAuxiliarArtPrecioTemp.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.POSAuxiliarArtPrecioTemp.ListaPrecios]
Carpeta=Lista
Clave=POSAuxiliarArtPrecioTemp.ListaPrecios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.POSAuxiliarArtPrecioTemp.PrecioAnterior]
Carpeta=Lista
Clave=POSAuxiliarArtPrecioTemp.PrecioAnterior
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.POSAuxiliarArtPrecioTemp.Precio]
Carpeta=Lista
Clave=POSAuxiliarArtPrecioTemp.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




























[Lista.POSAuxiliarArtPrecioTemp.Unidad]
Carpeta=Lista
Clave=POSAuxiliarArtPrecioTemp.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco










[Lista.ListaEnCaptura]
(Inicio)=POSAuxiliarArtPrecioTemp.Articulo
POSAuxiliarArtPrecioTemp.Articulo=POSAuxiliarArtPrecioTemp.SubCuenta
POSAuxiliarArtPrecioTemp.SubCuenta=POSAuxiliarArtPrecioTemp.ListaPrecios
POSAuxiliarArtPrecioTemp.ListaPrecios=POSAuxiliarArtPrecioTemp.PrecioAnterior
POSAuxiliarArtPrecioTemp.PrecioAnterior=POSAuxiliarArtPrecioTemp.Precio
POSAuxiliarArtPrecioTemp.Precio=POSAuxiliarArtPrecioTemp.Unidad
POSAuxiliarArtPrecioTemp.Unidad=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PROTOTIPO
PROTOTIPO=ALTA
ALTA=BLOQUEADO
BLOQUEADO=DESCONTINUADO
DESCONTINUADO=BAJA
BAJA=(Fin)

[Lista.ListaAcciones]
(Inicio)=Actualizar
Actualizar=Todo
Todo=Quitar
Quitar=(Fin)



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Generar
Generar=(Fin)
