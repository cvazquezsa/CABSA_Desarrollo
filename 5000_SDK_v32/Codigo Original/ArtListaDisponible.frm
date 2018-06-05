[Forma]
Clave=ArtListaDisponible
Nombre=e(<T>Existencias Disponibles<T>)+<T> - <T>+Si(ConDatos(Info.Almacen2), <T>(Seleccionados)<T>, Info.Almacen)
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=0
PosicionInicialArriba=79
PosicionInicialAltura=466
PosicionInicialAncho=860
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaEscCerrar=S
BarraHerramientas=S
Comentarios=Si(ConDatos(Info.AlmGrupo), e(<T>Grupo<T>)+<T>: <T>+Info.AlmGrupo, e(<T>Almacén<T>)+<T>: <T>+Si(ConDatos(Info.Almacen), Si(ConDatos(Info.Almacen2), <T>(Seleccionados)<T>, Info.Almacen), <T>(Todos)<T>))
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=532

VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.AlmGrupo, Nulo)<BR>Asigna(Info.Almacen2, Nulo)<BR>Asigna(Info.Almacen3, Nulo)<BR>Asigna(Info.Almacen4, Nulo)<BR>Asigna(Info.Almacen5, Nulo)<BR>Asigna(Info.Almacen6, Nulo)<BR>Asigna(Info.Almacen7, Nulo)   <BR>Asigna(Info.Almacen8, Nulo)<BR>Asigna(Info.Almacen9, Nulo)<BR>Asigna(Info.Almacen10, Nulo)<BR>Asigna(Info.Almacen, Nulo)
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
Vista=ArtDisponibleDesc
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
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
FiltroTipo=Múltiple (por grupos)
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
FiltroSituacionTodo=S
MenuLocal=S
ListaAcciones=(Lista)

FuenteBusqueda={MS Sans Serif, 8, Negro, []}
IconosNombre=ArtDisponibleDesc:Art.Articulo
FiltroGeneral=ArtDisponible.Empresa=<T>{Empresa}<T><BR>{Si(ConDatos(Info.AlmGrupo), <T> AND Alm.Grupo=<T>+Comillas(Info.AlmGrupo), <T><T>)}<BR>{Si(ConDatos(Info.Almacen), Si(ConDatos(Info.Almacen2), <T> AND ArtDisponible.Almacen IN (<T>+Comillas(Info.Almacen)+<T>,<T>+Comillas(Info.Almacen2)+<T>,<T>+Comillas(Info.Almacen3)+<T>,<T>+Comillas(Info.Almacen4)+<T>,<T>+Comillas(Info.Almacen5)+<T>,<T>+Comillas(Info.Almacen6)+<T>,<T>+Comillas(Info.Almacen7)+<T>,<T>+Comillas(Info.Almacen8)+<T>,<T>+Comillas(Info.Almacen9)+<T>,<T>+Comillas(Info.Almacen10)+<T>)<T>, <T> AND ArtDisponible.Almacen=<T>+Comillas(Info.Almacen)), <T><T>)}
[Lista.Columnas]
Articulo=92
Descripcion1=224
PrecioLista=71
Disponible=57
Tipo=46
0=112
1=314
EstatusNombre=77

2=-2
3=-2
4=-2
Almacen=90
Nombre=229
Grupo=100
Sucursal=46
5=-2
6=-2
[Acciones.Info]
Nombre=Info
Boton=34
NombreEnBoton=S
NombreDesplegar=&Artículo
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
ConCondicion=S
Expresion=Asigna(Filtro.Almacen, Info.Almacen)<BR>Forma(<T>ArtInfo<T>)<BR>Asigna(Info.Almacen, Filtro.Almacen)
EjecucionCondicion=ConDatos(ArtDisponibleDesc:Art.Articulo)
AntesExpresiones=Asigna(Info.Articulo, ArtDisponibleDesc:Art.Articulo)

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

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

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

[Acciones.Almacen]
Nombre=Almacen
Boton=16
NombreEnBoton=S
NombreDesplegar=&Almacén
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
ConCondicion=S
Visible=S

ActivoCondicion=Vacio(Info.AlmGrupo)
EjecucionCondicion=Forma(<T>EspecificaDiezAlmacenes<T>) //Antes EspecificarAlmacen
[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Art.PrecioLista]
Carpeta=Lista
Clave=Art.PrecioLista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Acciones.Grupo]
Nombre=Grupo
Boton=87
NombreEnBoton=S
NombreDesplegar=&Grupo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=Forma(<T>EspecificarAlmGrupo<T>)

[Lista.ArtDisponible.Almacen]
Carpeta=Lista
Clave=ArtDisponible.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.ArtCompraPendiente]
Nombre=ArtCompraPendiente
Boton=0
NombreDesplegar=C&ompras Pendientes
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtCompraPendiente
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+O
EjecucionCondicion=ConDatos(ArtDisponibleDesc:ArtDisponible.Articulo)
AntesExpresiones=Asigna(Info.Articulo, ArtDisponibleDesc:ArtDisponible.Articulo)<BR>Asigna(Info.Almacen, Nulo)

[Acciones.ArtVentaPendiente]
Nombre=ArtVentaPendiente
Boton=0
NombreDesplegar=&Ventas Pendientes
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtVentaPendiente
Activo=S
Visible=S
Antes=S
ConCondicion=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+V
EjecucionCondicion=ConDatos(ArtDisponibleDesc:ArtDisponible.Articulo)
AntesExpresiones=Asigna(Info.Articulo, ArtDisponibleDesc:ArtDisponible.Articulo)<BR>Asigna(Info.Almacen, ArtDisponibleDesc:ArtDisponible.Almacen)

[Acciones.LocalArtInfo]
Nombre=LocalArtInfo
Boton=0
NombreDesplegar=Información del Artículo
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
ConCondicion=S
Visible=S
EjecucionCondicion=ConDatos(ArtDisponibleDesc:ArtDisponible.Articulo)
Antes=S
AntesExpresiones=Asigna(Info.Articulo, ArtDisponibleDesc:ArtDisponible.Articulo)


[ArtDisponible.ListaEnCaptura]
(Inicio)=Articulo
Articulo=Descripcion1
Descripcion1=PrecioLista
PrecioLista=Disponible
Disponible=(Fin)




[Almacenes.Columnas]
0=108
1=-2





















































































































































[Lista.ArtDisponible.Disponible]
Carpeta=Lista
Clave=ArtDisponible.Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtDisponible.Apartado]
Carpeta=Lista
Clave=ArtDisponible.Apartado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtDisponible.DispMenosApartado]
Carpeta=Lista
Clave=ArtDisponible.DispMenosApartado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=Art.PrecioLista
Art.PrecioLista=ArtDisponible.Disponible
ArtDisponible.Disponible=ArtDisponible.Apartado
ArtDisponible.Apartado=ArtDisponible.DispMenosApartado
ArtDisponible.DispMenosApartado=ArtDisponible.Almacen
ArtDisponible.Almacen=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PROTOTIPO
PROTOTIPO=ALTA
ALTA=BLOQUEADO
BLOQUEADO=DESCONTINUADO
DESCONTINUADO=BAJA
BAJA=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalArtInfo
LocalArtInfo=ArtCompraPendiente
ArtCompraPendiente=ArtVentaPendiente
ArtVentaPendiente=(Fin)





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Info
Info=Almacen
Almacen=Grupo
Grupo=Campos
Campos=(Fin)
