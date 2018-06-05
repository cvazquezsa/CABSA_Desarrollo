[Forma]
Clave=AgentPendienteLista
Nombre=<T>Pendientes del Agente<T>
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=373
PosicionInicialArriba=328
PosicionInicialAltura=367
PosicionInicialAncho=533
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
Comentarios=Lista(Info.Agente,Info.Nombre, Info.Moneda)
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=340

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AgentPendienteLista
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
OtroOrden=S
ListaOrden=ID<TAB>(Acendente)
PestanaOtroNombre=S
FiltroPredefinido=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
MenuLocal=S
ListaAcciones=Actualizar
PermiteLocalizar=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=FechaEmision
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
IconosNombre=AgentPendienteLista:Mov+<T> <T>+AgentPendienteLista:MovID
FiltroGeneral=Agente=<T>{Info.Agente}<T> AND<BR>Moneda=<T>{Info.Moneda}<T> AND<BR>Empresa=<T>{Empresa}<T> AND<BR>Mov=<T>{Info.Mov}<T>

[Lista.Columnas]
Mov=114
MovID=64
FechaEmision=83
Vencimiento=76
Saldo=93
Importe=82
0=111
1=79
Referencia=110

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreDesplegar=&Seleccionar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Visible=S
Activo=S
NombreEnBoton=S
EnBarraHerramientas=S
Antes=S
AntesExpresiones=Asigna(Info.MovID, AgentPendienteLista:MovID ) <BR>Si(MovTipoEn(<T>AGENT<T>, AgentPendienteLista:Mov, (AGENT.D, AGENT.A)), Asigna(Info.Importe, -AgentPendienteLista:Saldo), Asigna(Info.Importe, AgentPendienteLista:Saldo))<BR>Si(Info.MovTipo = <T>AGENT.CO<T>, Asigna(Info.Importe, -Info.Importe))

[Lista.Referencia]
Carpeta=Lista
Clave=Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.FechaEmision]
Carpeta=Lista
Clave=FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Saldo]
Carpeta=Lista
Clave=Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

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

[Lista.ListaEnCaptura]
(Inicio)=Referencia
Referencia=FechaEmision
FechaEmision=Saldo
Saldo=(Fin)
