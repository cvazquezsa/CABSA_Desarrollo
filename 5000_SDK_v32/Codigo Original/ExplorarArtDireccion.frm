[Forma]
Clave=ExplorarArtDireccion
Nombre=Artículos
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=122
PosicionInicialArriba=128
PosicionInicialAltura=504
PosicionInicialAncho=780
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=477
MovModulo=INV

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
FiltroGrupo1=Art.Estado
FiltroGrupo2=Art.Delegacion
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=25
FiltroListasRama=INV
FiltroListasAplicaEn=Art.Articulo
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
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
FiltroGrupo3=Art.Colonia
FiltroGrupo4=Art.CodigoPostal
FiltroFechasCampo=Art.RevisionSiguiente
FiltroFechasDefault=(Todo)
FiltroFechasVencimiento=S
FiltroSituacion=S
FiltroSituacionTodo=S
IconosNombre=Art:Art.Articulo
FiltroValida1=Art.Estado
FiltroValida2=Art.Delegacion
FiltroValida3=Art.Colonia
FiltroValida4=Art.CodigoPostal

[Lista.Art.Tipo]
Carpeta=Lista
Clave=Art.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=137
1=287

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

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
NombreDesplegar=Información
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
NombreDesplegar=Información
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
NombreDesplegar=&Presentación preliminar
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
ColorFuente=Negro

[Acciones.Plan]
Nombre=Plan
Boton=88
NombreDesplegar=&Plan
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=PlanArt
ConCondicion=S
Antes=S
Visible=S
ActivoCondicion=no Art:Art.EsFormula
EjecucionCondicion=ConDatos(Art:Art.Articulo)
AntesExpresiones=Asigna(Info.Articulo, Art:Art.Articulo)<BR>Asigna(Info.Almacen, Art:Art.AlmacenROP)<BR>Asigna(Info.Descripcion, Art:Art.Descripcion1)<BR>Asigna(Info.ArtTipoOpcion, Art:Art.TipoOpcion)

[Acciones.MovArt]
Nombre=MovArt
Boton=25
NombreDesplegar=<T>Generar <T>+ConfigMov.InvSolicitud 
EnBarraHerramientas=S
TipoAccion=Dialogos
ClaveAccion=MovArt
Visible=S
EspacioPrevio=S
Antes=S
ConCondicion=S
ActivoCondicion=Usuario.ArtMov
EjecucionCondicion=ConDatos(Art:Art.Articulo)
AntesExpresiones=Asigna(Info.Articulo, Art:Art.Articulo)<BR>Asigna(Info.Descripcion, Art:Art.Descripcion1)

[Acciones.LocalMovArt]
Nombre=LocalMovArt
Boton=0
UsaTeclaRapida=S
TeclaRapida=F12
NombreDesplegar=<T>Generar <T>+ConfigMov.InvSolicitud
EnMenu=S
TipoAccion=Dialogos
ClaveAccion=MovArt
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
ActivoCondicion=Usuario.ArtMov
EjecucionCondicion=ConDatos(Art:Art.Articulo)
AntesExpresiones=Asigna(Info.Articulo, Art:Art.Articulo)<BR>Asigna(Info.Descripcion, Art:Art.Descripcion1)

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

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=MovArt
MovArt=ArtInfo
ArtInfo=Plan
Plan=Campos
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
LocalArtInfo=LocalImprimir
LocalImprimir=LocalPreliminar
LocalPreliminar=LocalExcel
LocalExcel=LocalMovArt
LocalMovArt=LocalCampos
LocalCampos=(Fin)
