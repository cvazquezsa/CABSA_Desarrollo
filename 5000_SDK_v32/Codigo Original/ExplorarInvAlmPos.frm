[Forma]
Clave=ExplorarInvAlmPos
Nombre=<T>Explorando - Inventarios por Almacenes y Posiciones<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=199
PosicionInicialArriba=147
PosicionInicialAltura=453
PosicionInicialAncho=882
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=586

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PosicionExistencia
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
FiltroListasRama=INV
FiltroListasAplicaEn=Articulo
FiltroGrupo1=PosicionExistencia.Almacen
FiltroTodo=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
FiltroTodoFinal=S
MenuLocal=S
ListaAcciones=LocalInformacion
PestanaOtroNombre=S
PestanaNombre=Artículos
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
PermiteLocalizar=S
FiltroAplicaEn=Alm.Almacen
FiltroGrupo2=Art.Categoria
OtroOrden=S
ListaOrden=PosicionExistencia.Articulo<TAB>(Acendente)
FiltroSucursalesSinTodas=S

FiltroAplicaO=ArtExistenciaReservado.Almacen
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Alm
FiltroGrupo3=Art.Grupo
FiltroGrupo4=Art.Familia
FiltroGrupo5=Art.Fabricante
IconosNombre=PosicionExistencia:PosicionExistencia.Articulo
FiltroGeneral=PosicionExistencia.Empresa=<T>{Empresa}<T> AND<BR>ISNULL(PosicionExistencia.Existencia, 0)<>0
[Lista.Columnas]
Articulo=124
Descripcion1=256
Costo=95
Existencia=74
Valor=100
Existencias=68
0=99
1=148

2=71
3=91
4=-2
5=-2
6=-2
7=-2
8=-2
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

[Acciones.Informacion]
Nombre=Informacion
Boton=34
NombreDesplegar=&Artículo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Antes=S
Visible=S
NombreEnBoton=S
ConCondicion=S

EjecucionCondicion=ConDatos(PosicionExistencia:PosicionExistencia.Articulo)
AntesExpresiones=Asigna( Info.Articulo, PosicionExistencia:PosicionExistencia.Articulo)
[Acciones.LocalInformacion]
Nombre=LocalInformacion
Boton=0
NombreDesplegar=&Información del Artículo
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Visible=S
Antes=S

AntesExpresiones=Asigna(Info.Articulo, PosicionExistencia:PosicionExistencia.Articulo)
[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco




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
Visible=S
ActivoCondicion=Usuario.Costos

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






[Lista.PosicionExistencia.Almacen]
Carpeta=Lista
Clave=PosicionExistencia.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.PosicionExistencia.Posicion]
Carpeta=Lista
Clave=PosicionExistencia.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.PosicionExistencia.Existencia]
Carpeta=Lista
Clave=PosicionExistencia.Existencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco










[Lista.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=PosicionExistencia.Almacen
PosicionExistencia.Almacen=PosicionExistencia.Posicion
PosicionExistencia.Posicion=PosicionExistencia.Existencia
PosicionExistencia.Existencia=(Fin)



















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=Informacion
Informacion=Mostrar Campos
Mostrar Campos=(Fin)
