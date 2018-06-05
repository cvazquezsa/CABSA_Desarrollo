[Forma]
Clave=GestionAgendaMovLista
Nombre=Agregar Movimientos a la Agenda
Icono=65
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=538
PosicionInicialArriba=319
PosicionInicialAlturaCliente=526
PosicionInicialAncho=843
Comentarios=Lista(Info.Mov, Info.MovID)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
VentanaExclusiva=S

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Mov
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
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Movimientos
Filtros=S
BusquedaRapidaControles=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroFechas=S
FiltroSucursales=S
FiltroFechasCampo=Mov.FechaEmision
FiltroFechasDefault=Hoy
IconosSeleccionMultiple=S
FiltroAutoCampo=Mov.Modulo
FiltroAutoValidar=Modulo.Nombre
FiltroEstilo=Folder (1 línea)
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=Mov:Movimiento
FiltroGeneral=Mov.Empresa=<T>{Empresa}<T>

[Lista.Mov.FechaEmision]
Carpeta=Lista
Clave=Mov.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Mov.Concepto]
Carpeta=Lista
Clave=Mov.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Mov.Referencia]
Carpeta=Lista
Clave=Mov.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Mov.Observaciones]
Carpeta=Lista
Clave=Mov.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=166
1=86

[Acciones.Todo]
Nombre=Todo
Boton=55
NombreEnBoton=S
NombreDesplegar=Seleccionar &Todo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.LocalTodo]
Nombre=LocalTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.LocalQuitar]
Nombre=LocalQuitar
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Antes=S
AntesExpresiones=RegistrarSeleccionModuloID(<T>Lista<T>, <T>Mov.Modulo<T>, <T>Mov.ID<T>)<BR>EjecutarSQL(<T>spGestionAgendaOtrosModulos :tEmpresa, :nSucursal, :nEstacion, :nID<T>, Empresa, Sucursal, EstacionTrabajo, Info.ID)

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

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Todo
Todo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Mov.FechaEmision
Mov.FechaEmision=Mov.Concepto
Mov.Concepto=Mov.Referencia
Mov.Referencia=Mov.Observaciones
Mov.Observaciones=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=(Fin)
