[Forma]
Clave=ExplorarProdDPendiente
Nombre=<T>Explorando - Producción Pendiente<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=107
PosicionInicialArriba=142
PosicionInicialAltura=477
PosicionInicialAncho=810
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
EsMovimiento=S
TituloAuto=S
MovModulo=PROD
MovEspecificos=Todos
SinCondicionDespliege=S
PosicionInicialAlturaCliente=450

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProdT
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtFam
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtGrupo
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=Fabricante
FiltroAplicaEn1=Art.Categoria
FiltroAplicaEn2=Art.Familia
FiltroAplicaEn3=Art.Grupo
FiltroAplicaEn4=Art.Fabricante
FiltroAncho=20
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroFechas=S
FiltroMonedas=S
FiltroFechasCampo=Prod.FechaEmision
FiltroFechasDefault=(Todo)
FiltroMonedasCampo=Prod.Moneda
FiltroMovsTodos=S
FiltroMovDefault=(Todos)
FiltroListaEstatus=PENDIENTE
FiltroEstatusDefault=PENDIENTE
PermiteLocalizar=S
FiltroListas=S
FiltroListasRama=PROD
FiltroListasAplicaEn=ProdD.Articulo
FiltroMovs=S
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
FiltroFechasCancelacion=Prod.FechaCancelacion
FiltroSucursales=S
IconosConSenales=S
FiltroProyectos=S
FiltroUENs=S
FiltroUENsCampo=Prod.UEN
IconosNombre=ProdT:Prod.Mov+<T> <T>+ProdT:Prod.MovID
FiltroGeneral=Prod.Empresa=<T>{Empresa}<T> AND Prod.Estatus=<T>PENDIENTE<T> AND ProdD.CantidadPendiente>0

[Lista.Columnas]
0=132
1=83

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
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

[Acciones.Mostrar Campos]
Nombre=Mostrar Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
NombreDesplegar=&Artículo
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
NombreEnBoton=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(ProdT:ProdD.Articulo)
AntesExpresiones=Asigna(Info.Articulo, ProdT:ProdD.Articulo)

[Acciones.MovPropiedades]
Nombre=MovPropiedades
Boton=35
NombreEnBoton=S
NombreDesplegar=<T>&Movimiento<T>
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ProdT:Prod.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>PROD<T>)<BR>Asigna(Info.ID, ProdT:Prod.ID)

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Presentacion preliminar]
Nombre=Presentacion preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Lista.Prod.FechaEmision]
Carpeta=Lista
Clave=Prod.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdD.Ruta]
Carpeta=Lista
Clave=ProdD.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdD.Centro]
Carpeta=Lista
Clave=ProdD.Centro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdD.Almacen]
Carpeta=Lista
Clave=ProdD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdD.Articulo]
Carpeta=Lista
Clave=ProdD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdD.CantidadPendiente]
Carpeta=Lista
Clave=ProdD.CantidadPendiente
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=ArtInfo
ArtInfo=MovPropiedades
MovPropiedades=Mostrar Campos
Mostrar Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Prod.FechaEmision
Prod.FechaEmision=ProdD.Articulo
ProdD.Articulo=ProdD.Ruta
ProdD.Ruta=ProdD.Centro
ProdD.Centro=ProdD.Almacen
ProdD.Almacen=ProdD.CantidadPendiente
ProdD.CantidadPendiente=(Fin)
