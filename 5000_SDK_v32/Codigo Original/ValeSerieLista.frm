[Forma]
Clave=ValeSerieLista
Nombre=Vales
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=716
PosicionInicialArriba=369
PosicionInicialAltura=454
PosicionInicialAncho=488
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
FiltroEstatus=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=DISPONIBLE
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
IconosNombre=ValeSerie:ValeSerie.Serie
IconosSubTitulo=<T>Serie<T>
ElementosPorPagina=200

[Lista.ValeSerie.Precio]
Carpeta=Lista
Clave=ValeSerie.Precio
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=172
1=82
Serie=130
FechaEmision=94
Precio=64
EstatusNombre=104

[Lista.ValeSerie.FechaEmision]
Carpeta=Lista
Clave=ValeSerie.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
NombreDesplegar=&Quitar Seleccion
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Seleccionar Todo
Seleccionar Todo=Quitar Seleccion
Quitar Seleccion=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ValeSerie.FechaEmision
ValeSerie.FechaEmision=ValeSerie.Precio
ValeSerie.Precio=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=DISPONIBLE
DISPONIBLE=CIRCULACION
CIRCULACION=COBRADO
COBRADO=BLOQUEADO
BLOQUEADO=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)
