[Forma]
Clave=VentaPedidoAnticipoPendienteLista
Nombre=Movimientos Pendientes
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=1827
PosicionInicialArriba=284
PosicionInicialAlturaCliente=418
PosicionInicialAncho=825
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
EsMovimiento=S
MovModulo=VTAS
TituloAuto=S
MovEspecificos=Todos

Comentarios=Info.Cliente
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaPedidoAnticipoPendiente
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=VentaPedidoAnticipoPendiente.ID<TAB>(Acendente)
FiltroPredefinido=S
FiltroAutoCampo=VentaPedidoAnticipoPendiente.Mov
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=VentaPedidoAnticipoPendiente.FechaRequerida
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroMonedasCampo=VentaPedidoAnticipoPendiente.Moneda
FiltroFechasNombre=&Fecha Requerida
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Pendientes
FiltroMovsTodos=S
FiltroMovDefault=(Todos)
FiltroAplicaEn=VentaPedidoAnticipoPendiente.Mov
FiltroGrupo1=VentaPedidoAnticipoPendiente.Mov
FiltroValida1=VentaPedidoAnticipoPendiente.Mov
FiltroTodo=S
FiltroTodoFinal=S

IconosNombre=VentaPedidoAnticipoPendiente:VentaPedidoAnticipoPendiente.Mov+<T> <T>+VentaPedidoAnticipoPendiente:VentaPedidoAnticipoPendiente.MovID
FiltroGeneral=VentaPedidoAnticipoPendiente.Empresa=<T>{Empresa}<T>  AND<BR>VentaPedidoAnticipoPendiente.Cliente = <T>{Info.Cliente}<T>
[Lista.VentaPedidoAnticipoPendiente.FechaEmision]
Carpeta=Lista
Clave=VentaPedidoAnticipoPendiente.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.VentaPedidoAnticipoPendiente.FechaRequerida]
Carpeta=Lista
Clave=VentaPedidoAnticipoPendiente.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VentaPedidoAnticipoPendiente.Cliente]
Carpeta=Lista
Clave=VentaPedidoAnticipoPendiente.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Cte.Nombre]
Carpeta=Lista
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.VentaPedidoAnticipoPendiente.Referencia]
Carpeta=Lista
Clave=VentaPedidoAnticipoPendiente.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
0=115
1=79

2=-2
3=-2
4=-2
5=-2
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

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
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








[Lista.ListaEnCaptura]
(Inicio)=VentaPedidoAnticipoPendiente.FechaEmision
VentaPedidoAnticipoPendiente.FechaEmision=VentaPedidoAnticipoPendiente.FechaRequerida
VentaPedidoAnticipoPendiente.FechaRequerida=VentaPedidoAnticipoPendiente.Cliente
VentaPedidoAnticipoPendiente.Cliente=Cte.Nombre
Cte.Nombre=VentaPedidoAnticipoPendiente.Referencia
VentaPedidoAnticipoPendiente.Referencia=(Fin)



[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Cancelar
Cancelar=Personalizar
Personalizar=(Fin)
