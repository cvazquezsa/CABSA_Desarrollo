[Forma]
Clave=VentaPendienteLista
Nombre=Movimientos Pendientes
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=227
PosicionInicialArriba=174
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
Vista=VentaPendiente
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
ListaOrden=VentaPendiente.ID<TAB>(Acendente)
FiltroPredefinido=S
FiltroAutoCampo=VentaPendiente.Mov
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=VentaPendiente.FechaRequerida
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroMonedasCampo=VentaPendiente.Moneda
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
FiltroAplicaEn=VentaPendiente.Mov
FiltroGrupo1=VentaPendiente.Mov
FiltroValida1=VentaPendiente.Mov
FiltroTodo=S
FiltroTodoFinal=S

IconosNombre=VentaPendiente:VentaPendiente.Mov+<T> <T>+VentaPendiente:VentaPendiente.MovID
FiltroGeneral=VentaPendiente.Empresa=<T>{Empresa}<T>
[Lista.VentaPendiente.FechaEmision]
Carpeta=Lista
Clave=VentaPendiente.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.VentaPendiente.FechaRequerida]
Carpeta=Lista
Clave=VentaPendiente.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VentaPendiente.Cliente]
Carpeta=Lista
Clave=VentaPendiente.Cliente
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

[Lista.VentaPendiente.Referencia]
Carpeta=Lista
Clave=VentaPendiente.Referencia
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
(Inicio)=VentaPendiente.FechaEmision
VentaPendiente.FechaEmision=VentaPendiente.FechaRequerida
VentaPendiente.FechaRequerida=VentaPendiente.Cliente
VentaPendiente.Cliente=Cte.Nombre
Cte.Nombre=VentaPendiente.Referencia
VentaPendiente.Referencia=(Fin)





[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Cancelar
Cancelar=Personalizar
Personalizar=(Fin)
