
[Forma]
Clave=ProyPendientesLista
Icono=0
CarpetaPrincipal=Lista
Modulos=(Todos)
Nombre=Pendientes

ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=422
PosicionInicialAncho=938
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=171
PosicionInicialArriba=172
EsMovimiento=S
TituloAuto=S
MovEspecificos=Todos
MovModulo=PROY
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyPendientes
Fuente={Tahoma, 8, Negro, []}
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

OtroOrden=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
PestanaOtroNombre=S
PestanaNombre=Movimientos
ListaOrden=Proyecto.MovID<TAB>(Acendente)
BusquedaRapida=S
BusquedaEnLinea=S


BusquedaInicializar=S
BusquedaRespetarControles=S
FiltroFechas=S
FiltroFechasCampo=Proyecto.FechaEmision
FiltroFechasDefault=(Todo)
Filtros=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosNombre=ProyPendientes:Proyecto.Proyecto
IconosSubTitulo=<T>Proyecto<T>
ElementosPorPaginaEsp=200
FiltroAplicaEn=Proyecto.Mov
FiltroPredefinido=S
FiltroGrupo1=Proyecto.Mov
FiltroValida1=Proyecto.Mov
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroTodoFinal=S
FiltroAncho=30
FiltroGeneral=Proyecto.Estatus = <T>{EstatusPendiente}<T> AND Proyecto.Empresa = <T>{Empresa}<T>
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
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

[Lista.Columnas]
0=148
1=61
2=77

























3=103
4=99
5=160
6=132

[Lista.Proyecto.Mov]
Carpeta=Lista
Clave=Proyecto.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Proyecto.MovID]
Carpeta=Lista
Clave=Proyecto.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Proyecto.FechaEmision]
Carpeta=Lista
Clave=Proyecto.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Proyecto.UltimoCambio]
Carpeta=Lista
Clave=Proyecto.UltimoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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

[Lista.Proyecto.Referencia]
Carpeta=Lista
Clave=Proyecto.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco










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
(Inicio)=Proyecto.Mov
Proyecto.Mov=Proyecto.MovID
Proyecto.MovID=Proyecto.FechaEmision
Proyecto.FechaEmision=Proyecto.UltimoCambio
Proyecto.UltimoCambio=Cte.Nombre
Cte.Nombre=Proyecto.Referencia
Proyecto.Referencia=(Fin)





[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Cancelar
Cancelar=Personalizar
Personalizar=(Fin)
