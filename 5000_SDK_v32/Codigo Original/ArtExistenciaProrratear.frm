[Forma]
Clave=ArtExistenciaProrratear
Nombre=<T>Prorratear en Base a Existencias<T>
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=145
PosicionInicialArriba=133
PosicionInicialAltura=466
PosicionInicialAncho=733
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaEscCerrar=S
BarraHerramientas=S
Comentarios=Info.Almacen
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=468
VentanaExclusiva=S
ExpresionesAlMostrar=Asigna(Info.AlmGrupo, Nulo)

[ArtDisponible]
Estilo=Hoja
Pestana=
Clave=ArtDisponible
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtDisponible
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=30
Filtros=
BusquedaAVariable=
BusquedaEnLinea=S

[ArtDisponible.Columnas]
Articulo_1=109
Descripcion1=203
Descripcion2=1534
Almacen=51
SubCuenta=103
Disponible=57
Articulo=115
Unidad=49
Tipo=124
PrecioLista=70

[ArtDisponible.Disponible]
Carpeta=ArtDisponible
Clave=Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[ArtDisponible.Articulo]
Carpeta=ArtDisponible
Clave=Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S

[ArtDisponible.Descripcion1]
Carpeta=ArtDisponible
Clave=Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S

[ArtDisponible.PrecioLista]
Carpeta=ArtDisponible
Clave=PrecioLista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S

[Lista]
Estilo=Iconos
Clave=Lista
BusquedaRapidaControles=S
Zona=A1
Vista=ArtSubExistenciaInv
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=22
BusquedaEnLinea=S
FiltroFechasNormal=S
Filtros=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtCat
FiltroPredefinido=S
FiltroAplicaEn=Categoria
FiltroAncho=22
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroTodoFinal=S
FiltroNullNombre=(sin clategoría)
FiltroRespetar=S
FiltroAplicaEn1=Art.Categoria
FiltroListas=S
FiltroListasRama=INV
FiltroListasAplicaEn=Art.Articulo
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtGrupo
FiltroAplicaEn2=Art.Grupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtFam
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=ArtLinea
FiltroAplicaEn3=Art.Familia
FiltroAplicaEn4=Art.Linea
OtroOrden=S
ListaOrden=Art.Articulo<TAB>(Acendente)
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
PermiteLocalizar=S
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=Fabricante
FiltroAplicaEn5=Art.Fabricante
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
PestanaOtroNombre=S
MostrarConteoRegistros=S
IconosSeleccionMultiple=S
MenuLocal=S
ListaAcciones=(Lista)
CarpetaVisible=S
ListaEnCaptura=(Lista)
IconosNombre=ArtSubExistenciaInv:ArtSubExistenciaInv.Articulo
FiltroGeneral=ArtSubExistenciaInv.Empresa=<T>{Empresa}<T> AND ArtSubExistenciaInv.Almacen=<T>{Info.Almacen}<T> AND ArtSubExistenciaInv.Inventario>0

[Lista.Columnas]
Articulo=92
Descripcion1=224
PrecioLista=71
Disponible=57
Tipo=46
0=112
1=340
EstatusNombre=77

[Acciones.Info]
Nombre=Info
Boton=34
NombreDesplegar=&Infomación
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
ConCondicion=S
NombreEnBoton=S
EjecucionCondicion=ConDatos(ArtSubDisponibleDesc:Art.Articulo)
AntesExpresiones=Asigna(Info.Articulo, ArtSubDisponibleDesc:Art.Articulo)

[Art.Art.Articulo]
Carpeta=Art
Clave=Art.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Art.Art.Descripcion1]
Carpeta=Art
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100

[Art.Columnas]
Articulo=124
Descripcion1=244

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Todo]
Nombre=Todo
Boton=55
NombreEnBoton=S
NombreDesplegar=Seleccionar &Todo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.LocalTodo]
Nombre=LocalTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.LocalQuitar]
Nombre=LocalQuitar
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.Unidades]
Nombre=Unidades
Boton=65
NombreEnBoton=S
NombreDesplegar=&Unidades
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtUnidadDisponible
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(ArtSubDisponibleDesc:Art.Articulo)
Antes=S
AntesExpresiones=Asigna(Info.Articulo, ArtSubDisponibleDesc:Art.Articulo)<BR>Asigna(Info.Disponible, ArtSubDisponibleDesc:ArtSubDisponibleDesc.Disponible)
Visible=S

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtSubExistenciaInv.Inventario]
Carpeta=Lista
Clave=ArtSubExistenciaInv.Inventario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Prorratear]
Nombre=Prorratear
Boton=23
NombreEnBoton=S
NombreDesplegar=&Prorratear
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=Asigna(Info.Importe, Nulo)<BR>Forma(<T>EspecificarImporte<T>)
AntesExpresiones=RegistrarListaSt(<T>Lista<T>, <T>ArtSubExistenciaInv.Llave<T>)<BR>EjecutarSQL(<T>spArtExistenciaProrratear :nEstacion, :nID, :tEmp, :tAlm, :nImporte<T>, EstacionTrabajo, Info.ID, Empresa, Info.Almacen, Info.Importe)

[Forma.ListaAcciones]
(Inicio)=Prorratear
Prorratear=Cancelar
Cancelar=Todo
Todo=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Info
Info=Unidades
Unidades=Campos
Campos=(Fin)

[ArtDisponible.ListaEnCaptura]
(Inicio)=Articulo
Articulo=Descripcion1
Descripcion1=PrecioLista
PrecioLista=Disponible
Disponible=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PROTOTIPO
PROTOTIPO=ALTA
ALTA=BLOQUEADO
BLOQUEADO=DESCONTINUADO
DESCONTINUADO=BAJA
BAJA=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=ArtSubExistenciaInv.Inventario
ArtSubExistenciaInv.Inventario=(Fin)
