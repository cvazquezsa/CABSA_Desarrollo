[Forma]
Clave=HerrWebArt
Nombre=Generar Artículos eCommerce
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=386
PosicionInicialArriba=154
PosicionInicialAltura=425
PosicionInicialAncho=827
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S
MovModulo=(Todos)
PosicionInicialAlturaCliente=514

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
[Lista]
Estilo=Iconos
Clave=Lista
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=eCommerceArt
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=eCommerceArt.Descripcion1
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
FiltroValida1=ArtCat
FiltroPredefinido=S
FiltroAplicaEn=Art.Categoria
FiltroTipo=Múltiple (por Grupos)
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
FiltroListasAplicaEn=eCommerceArt.Articulo
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtFam
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=ArtLinea
FiltroAplicaEn1=eCommerceArt.Categoria
FiltroAplicaEn2=eCommerceArt.Grupo
FiltroAplicaEn3=eCommerceArt.Familia
FiltroAplicaEn4=eCommerceArt.Linea
MenuLocal=S
ListaAcciones=(Lista)
OtroOrden=S
ListaOrden=eCommerceArt.Articulo<TAB>(Acendente)
PermiteLocalizar=S
PestanaNombre= Artículos
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=Fabricante
FiltroAplicaEn5=eCommerceArt.Fabricante
FiltroArbol=Articulos
FiltroArbolAplica=eCommerceArt.Rama
FiltroSituacionTodo=S
PestanaOtroNombre=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
IconosSeleccionMultiple=S



IconosNombre=eCommerceArt:eCommerceArt.Articulo
FiltroGeneral=eCommerceArt.Tipo<><T>Estructura<T>
[Lista.Columnas]
Articulo=131
Descripcion1=244
0=172
1=451

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=36
NombreDesplegar=&Cerrar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Visible=S
Activo=S
NombreEnBoton=S
EnBarraHerramientas=S


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
[Acciones.Expresion]
Nombre=Expresion
Boton=7
NombreDesplegar=&Generar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
NombreEnBoton=S
GuardarAntes=S
EspacioPrevio=S






Expresion=RegistrarSeleccion(<T>HerrWebArt<T>) <BR>EjecutarSQL(<T>speCommerceHerrWebArt :nEstacion, :tEmpresa, :nSucursal<T>, EstacionTrabajo,Empresa,Sucursal)<BR>FormaModal(<T>WebArtTemp<T>)
[Lista.eCommerceArt.Descripcion1]
Carpeta=Lista
Clave=eCommerceArt.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco








[WebArtTemp.Columnas]
Articulo=124
Nombre=258
MarcaID=47
Nombre_1=133
Unidad=45
Cantidad=64
PermiteCompra=77
OcultarPrecio=68
Visible=38
Categoria1=100
Categoria2=110
Categoria3=125
Categoria4=106







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
(Inicio)=Seleccionar
Seleccionar=Expresion
Expresion=(Fin)
