[Forma]
Clave=ProcesarSurtidoTransito
Nombre=Cierre de Tarima
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=317
PosicionInicialArriba=130
PosicionInicialAltura=506
PosicionInicialAncho=646
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionSeccion1=91
PosicionInicialAlturaCliente=506
ExpresionesAlMostrar=Asigna(Info.MovFactura, ConfigMov.VentaFacturaNota)
EsConsultaExclusiva=S

PosicionSec1=321
PosicionCol1=444
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TMA
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
BusquedaRapidaControles=S
FiltroUsuarios=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PROCESAR
FiltroUsuarioDefault=(Todos)
FiltroFechasNormal=S
MenuLocal=S
ListaAcciones=(Lista)
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
FiltroFechasCampo=TMA.FechaEmision
FiltroFechasDefault=Hoy
IconosSeleccionMultiple=S
FiltroFechas=S
BusquedaRapida=S
BusquedaEnLinea=S
BusquedaRespetarFiltros=S
BusquedaInicializar=S
BusquedaRespetarUsuario=S
BusquedaAncho=20
BusquedaRespetarControlesNum=S
FiltroSucursales=S
FiltroFechasNombre=&Fecha
OtroOrden=S
ListaOrden=(Lista)






Filtros=S
FiltroPredefinido=S
FiltroGrupo1=TMA.Agente
FiltroValida1=TMA.Agente
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroEstatus=S
IconosNombre=TMA:TMA.Mov+<T> <T>+TMA:TMA.MovID
FiltroGeneral=TMA.Empresa=<T>{Empresa}<T> AND<BR>MovTipo.Clave = <T>TMA.TSUR<T> AND<BR>MovTipo.SubClave = <T>TMA.TSURP<T>
[Lista.Columnas]
0=174
1=91

2=93
3=102
[Acciones.Mostrar Campos]
Nombre=Mostrar Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreDesplegar=&Procesar selección
EnBarraHerramientas=S
TipoAccion=Controles Captura
Activo=S
Visible=S
NombreEnBoton=S
Antes=S
ClaveAccion=Actualizar Forma
EspacioPrevio=S

AntesExpresiones=RegistrarSeleccionID<BR>ProcesarSQL(<T>spProcesarTMASurtidoTransito :nEstacion, :tEmpresa, :fFecha, :tUsuario<T>, EstacionTrabajo, Empresa, Ahora, Usuario)
[Acciones.SeleccionarTodo]
Nombre=SeleccionarTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S


[(Variables).Info.Mov]
Carpeta=(Variables)
Clave=Info.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20


[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=55
NombreEnBoton=S
NombreDesplegar=Seleccionar &Todo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S
EspacioPrevio=S


[Acciones.Quitar Seleccion]
Nombre=Quitar Seleccion
Boton=0
NombreDesplegar=Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

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












[Lista.TMA.FechaEmision]
Carpeta=Lista
Clave=TMA.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.TMA.Referencia]
Carpeta=Lista
Clave=TMA.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.TMA.Observaciones]
Carpeta=Lista
Clave=TMA.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco




















[Detalle]
Estilo=Iconos
Clave=Detalle
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=TMAD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=TMA
LlaveLocal=TMAD.ID
LlaveMaestra=TMA.ID
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

IconosSubTitulo=<T>Movimiento<T>

IconosNombre=TMA:TMA.Mov + <T> <T> + TMA:TMA.MovID
[Detalle.AlmPos.ArticuloEsp]
Carpeta=Detalle
Clave=AlmPos.ArticuloEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.TMAD.CantidadPicking]
Carpeta=Detalle
Clave=TMAD.CantidadPicking
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.TMAD.PosicionDestino]
Carpeta=Detalle
Clave=TMAD.PosicionDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.AlmPosDestino.Descripcion]
Carpeta=Detalle
Clave=AlmPosDestino.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco




[Detalle.Columnas]
0=-2
1=-2
2=-2
3=-2
4=-2









5=-2
6=88



[Detalle.TMAD.Tarima]
Carpeta=Detalle
Clave=TMAD.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco












[Detalle.ListaEnCaptura]
(Inicio)=TMAD.Tarima
TMAD.Tarima=AlmPos.ArticuloEsp
AlmPos.ArticuloEsp=TMAD.CantidadPicking
TMAD.CantidadPicking=TMA.TarimaSurtido
TMA.TarimaSurtido=TMAD.PosicionDestino
TMAD.PosicionDestino=AlmPosDestino.Descripcion
AlmPosDestino.Descripcion=(Fin)

[Detalle.TMA.TarimaSurtido]
Carpeta=Detalle
Clave=TMA.TarimaSurtido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

























































[Lista.ListaEnCaptura]
(Inicio)=TMA.FechaEmision
TMA.FechaEmision=TMA.Referencia
TMA.Referencia=TMA.Observaciones
TMA.Observaciones=(Fin)

[Lista.ListaOrden]
(Inicio)=TMA.FechaEmision	(Acendente)
TMA.FechaEmision	(Acendente)=TMA.ID	(Acendente)
TMA.ID	(Acendente)=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=PROCESAR
PROCESAR=CONCLUIDO
CONCLUIDO=(Fin)

[Lista.ListaAcciones]
(Inicio)=SeleccionarTodo
SeleccionarTodo=Quitar Seleccion
Quitar Seleccion=(Fin)

















[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Afectar
Afectar=Seleccionar Todo
Seleccionar Todo=Mostrar Campos
Mostrar Campos=(Fin)
