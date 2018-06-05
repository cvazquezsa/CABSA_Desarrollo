[Forma]
Clave=ExplorarArtVenta
Nombre=Art�culo - Desplazamiento Art�culo
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=288
PosicionInicialArriba=121
PosicionInicialAltura=504
PosicionInicialAncho=789
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=448
MovModulo=INV

VentanaEscCerrar=S
VentanaEstadoInicial=Normal
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Articulos
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Art
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=CtaSituacion.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtFam
FiltroAplicaEn1=Art.Categoria
FiltroAplicaEn2=Art.Familia
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=25
FiltroListas=S
FiltroListasRama=INV
FiltroListasAplicaEn=Art.Articulo
FiltroRespetar=S
FiltroTipo=M�ltiple (por Grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=25
BusquedaEnLinea=S
CarpetaVisible=S
FiltroTodo=S
FiltroTodoFinal=S
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
OtroOrden=S
ListaOrden=Art.Articulo<TAB>(Acendente)
MenuLocal=S
PermiteLocalizar=S
ListaAcciones=(Lista)
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtGrupo
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=ArtLinea
FiltroAplicaEn3=Art.Grupo
FiltroAplicaEn4=Art.Linea
FiltroFechasCampo=Art.RevisionSiguiente
FiltroFechasDefault=(Todo)
FiltroFechasVencimiento=S
FiltroSituacion=S
FiltroSituacionTodo=S
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=Fabricante
FiltroAplicaEn5=Art.Fabricante

IconosNombre=Art:Art.Articulo
[Lista.Art.Tipo]
Carpeta=Lista
Clave=Art.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Columnas]
0=137
1=287

2=-2
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
NombreDesplegar=Presentaci�n preliminar
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

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
NombreDesplegar=Informaci�n
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Art:Art.Articulo)
AntesExpresiones=Asigna(Info.Articulo, Art:Art.Articulo)

[Acciones.LocalArtInfo]
Nombre=LocalArtInfo
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=Informaci�n
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Art:Art.Articulo)
AntesExpresiones=Asigna(Info.Articulo, Art:Art.Articulo)

[Acciones.LocalImprimir]
Nombre=LocalImprimir
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
NombreDesplegar=&Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.LocalPreliminar]
Nombre=LocalPreliminar
Boton=0
NombreDesplegar=&Presentaci�n preliminar
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Alt+F11

[Acciones.LocalExcel]
Nombre=LocalExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.LocalCampos]
Nombre=LocalCampos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
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



[Acciones.Otros1]
Nombre=Otros1
Menu=&Otros
EnMenu=S
TipoAccion=Expresion
Boton=0

[Acciones.Otros2]
Nombre=Otros2
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros3]
Nombre=Otros3
Menu=&Otros
EnMenu=S
TipoAccion=Expresion
Boton=0

[Acciones.Otros4]
Nombre=Otros4
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros5]
Nombre=Otros5
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros6]
Nombre=Otros6
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros7]
Nombre=Otros7
Menu=&Otros
EnMenu=S
TipoAccion=Expresion
Boton=0

[Acciones.Otros8]
Nombre=Otros8
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros9]
Nombre=Otros9
Menu=&Otros
EnMenu=S
TipoAccion=Expresion









[Acciones.ArtVenta]
Nombre=ArtVenta
Boton=49
NombreDesplegar=&Ventas
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtVenta
Activo=S
Visible=S









ConCondicion=S
Antes=S









EjecucionCondicion=ConDatos(Art:Art.Articulo)
AntesExpresiones=Asigna(Info.Articulo,Art:Art.Articulo)
[Acciones.LocalArtVenta]
Nombre=LocalArtVenta
Boton=0
NombreDesplegar=&Ventas
EnMenu=S
TipoAccion=Formas
ClaveAccion=ArtVenta
Activo=S
ConCondicion=S
Antes=S
Visible=S









UsaTeclaRapida=S
TeclaRapida=Ctrl+V
EjecucionCondicion=ConDatos(Art:Art.Articulo)
AntesExpresiones=Asigna(Info.Articulo,Art:Art.Articulo)




[Lista.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=Art.Tipo
Art.Tipo=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalArtInfo
LocalArtInfo=LocalArtVenta
LocalArtVenta=LocalImprimir
LocalImprimir=LocalPreliminar
LocalPreliminar=LocalExcel
LocalExcel=LocalCampos
LocalCampos=(Fin)

















































[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=ArtInfo
ArtInfo=ArtVenta
ArtVenta=Campos
Campos=Otros1
Otros1=Otros2
Otros2=Otros3
Otros3=Otros4
Otros4=Otros5
Otros5=Otros6
Otros6=Otros7
Otros7=Otros8
Otros8=Otros9
Otros9=(Fin)
