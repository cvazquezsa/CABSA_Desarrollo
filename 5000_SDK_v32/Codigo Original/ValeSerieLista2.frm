[Forma]
Clave=ValeSerieLista2
Nombre=Vales
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=532
PosicionInicialArriba=197
PosicionInicialAltura=454
PosicionInicialAncho=820
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=427

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ValeSerie
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Vales
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=CIRCULACION
FiltroFechasCampo=ValeSerie.FechaEmision
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasCancelacion=ValeSerie.FechaCancelacion
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
Filtros=S
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=ValeTipo
FiltroGrupo1=(Validaciones Memoria)
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todos)
FiltroAncho=20
FiltroEstilo=Folder (1 línea)
FiltroRespetar=S
FiltroTipo=Automático
FiltroAplicaEn=ValeSerie.Tipo
FiltroTodo=S
FiltroTodoFinal=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Serie<T>
ElementosPorPagina=200


IconosNombre=ValeSerie:ValeSerie.Serie
FiltroGeneral=ValeSerie.Estatus = <T>CIRCULACION<T>
[Lista.Columnas]
0=172
1=82
Serie=130
FechaEmision=94
Precio=64
EstatusNombre=104

2=142
[Lista.ValeSerie.FechaEmision]
Carpeta=Lista
Clave=ValeSerie.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

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
Boton=72
NombreEnBoton=S
NombreDesplegar=&Quitar Selección
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S




[Lista.Saldo]
Carpeta=Lista
Clave=Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





[Lista.ListaEnCaptura]
(Inicio)=ValeSerie.FechaEmision
ValeSerie.FechaEmision=Saldo
Saldo=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=DISPONIBLE
DISPONIBLE=CIRCULACION
CIRCULACION=COBRADO
COBRADO=BLOQUEADO
BLOQUEADO=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

















[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Seleccionar Todo
Seleccionar Todo=Quitar Seleccion
Quitar Seleccion=Personalizar
Personalizar=(Fin)
