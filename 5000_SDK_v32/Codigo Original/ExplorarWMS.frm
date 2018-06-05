[Forma]
Clave=ExplorarWMS
Nombre=<T>Explorando - WMS<T>
Icono=47
Modulos=TMA
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=0
PosicionInicialArriba=181
PosicionInicialAltura=496
PosicionInicialAncho=1182
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=469

VentanaEstadoInicial=Normal
EsMovimiento=S
TituloAuto=S
MovEspecificos=Todos
MovModulo=TMA
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TMAT
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=25
BusquedaEnLinea=S
FiltroFechas=S
FiltroFechasCampo=TMA.FechaEmision
FiltroFechasDefault=Hoy
FiltroMonedasCampo=Compra.Moneda
FiltroMovsTodos=S
FiltroMovDefault=(Todos)
FiltroEstatusDefault=(Todos)
PermiteLocalizar=S
FiltroSucursales=S
FiltroProyectos=S
FiltroUENsCampo=Compra.UEN


ListaEnCaptura=(Lista)
FiltroModificarEstatus=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S
FiltroGrupo1=TMAD.Almacen
FiltroGrupo2=Articulo
FiltroRespetar=S
FiltroTodoFinal=S
FiltroEstatus=S
FiltroListaEstatus=(Lista)
OtroOrden=S
ListaOrden=TMA.FechaEmision<TAB>(Acendente)
FiltroMovs=S
IconosConSenales=S
IconosNombre=TMAT:TMA.Mov+<T> <T>+TMAT:TMA.MovID
FiltroGeneral=(SELECT Estatus FROM Tarima WHERE Tarima = TMAD.Tarima) = <T>ALTA<T>
[Lista.Columnas]
0=121
1=89

2=-2
3=-2
4=-2
5=244
6=-2
7=-2
8=57
9=-2
10=-2
11=-2
12=53
13=72
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



EjecucionCondicion=ConDatos(TMAT:Articulo)
AntesExpresiones=Asigna(Info.Articulo, TMAT:Articulo)
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

EjecucionCondicion=ConDatos(TMAT:TMA.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>TMA<T>)<BR>Asigna(Info.ID, TMAT:TMA.ID)
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









[Lista.TMA.FechaEmision]
Carpeta=Lista
Clave=TMA.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.TMAD.Almacen]
Carpeta=Lista
Clave=TMAD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.TMAD.Tarima]
Carpeta=Lista
Clave=TMAD.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Articulo]
Carpeta=Lista
Clave=Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Descripcion1]
Carpeta=Lista
Clave=Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.TMAD.Posicion]
Carpeta=Lista
Clave=TMAD.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.TMAD.PosicionDestino]
Carpeta=Lista
Clave=TMAD.PosicionDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.AlmPosDestino.Tipo]
Carpeta=Lista
Clave=AlmPosDestino.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.TMA.Agente]
Carpeta=Lista
Clave=TMA.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[Lista.TMA.MontaCarga]
Carpeta=Lista
Clave=TMA.MontaCarga
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.TMA.Prioridad]
Carpeta=Lista
Clave=TMA.Prioridad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco



































































[Lista.ListaOrden]
(Inicio)=TMA.FechaEmision	(Acendente)
TMA.FechaEmision	(Acendente)=TMA.Almacen	(Acendente)
TMA.Almacen	(Acendente)=(Fin)














































[Lista.ListaEnCaptura]
(Inicio)=TMA.FechaEmision
TMA.FechaEmision=TMAD.Almacen
TMAD.Almacen=TMAD.Tarima
TMAD.Tarima=Articulo
Articulo=Descripcion1
Descripcion1=TMAD.Posicion
TMAD.Posicion=TMAD.PosicionDestino
TMAD.PosicionDestino=AlmPosDestino.Tipo
AlmPosDestino.Tipo=TMA.Agente
TMA.Agente=TMA.MontaCarga
TMA.MontaCarga=TMA.Prioridad
TMA.Prioridad=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=CONCLUIDO
CONCLUIDO=PENDIENTE
PENDIENTE=PROCESAR
PROCESAR=(Todos)
(Todos)=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=ArtInfo
ArtInfo=MovPropiedades
MovPropiedades=Mostrar Campos
Mostrar Campos=(Fin)
