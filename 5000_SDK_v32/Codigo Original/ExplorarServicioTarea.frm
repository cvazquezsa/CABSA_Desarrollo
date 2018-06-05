[Forma]
Clave=ExplorarServicioTarea
Nombre=Tareas
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=67
PosicionInicialArriba=178
PosicionInicialAltura=405
PosicionInicialAncho=890
EsMovimiento=S
TituloAuto=S
MovModulo=VTAS
MovEspecificos=Todos
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=378

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ExplorarServicioTarea
Fuente={MS Sans Serif, 8, Negro, []}
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
Filtros=S
BusquedaRapidaControles=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todas
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Automático
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroEstatus=S
FiltroFechas=S
FiltroSituacionTodo=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
FiltroFechasCampo=Venta.FechaEmision
FiltroFechasDefault=Este Mes
FiltroMovsTodos=S
BusquedaRapida=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroUsuarios=S
FiltroUsuarioDefault=(Todos)
PestanaOtroNombre=S
PestanaNombre=Tareas
FiltroAutoCampo=TareaEstado.Estado
FiltroAutoValidar=TareaEstado.NombrePlural
FiltroAplicaEn=ServicioTarea.Estado
FiltroEstilo=Folder (1 línea)
FiltroAutoOrden=TareaEstado.Orden
FiltroTodo=S
FiltroTodoFinal=S
FiltroSucursales=S
IconosNombre=ExplorarServicioTarea:Venta.Mov+<T> <T>+ExplorarServicioTarea:Venta.MovID
FiltroGeneral=Venta.Empresa=<T>{Empresa}<T> AND<BR>Venta.Mov IN ({MovListaSQL(<T>VTAS<T>, VTAS.S)})

[Lista.ServicioTarea.Tarea]
Carpeta=Lista
Clave=ServicioTarea.Tarea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ServicioTarea.Problema]
Carpeta=Lista
Clave=ServicioTarea.Problema
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=150
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ServicioTarea.Solucion]
Carpeta=Lista
Clave=ServicioTarea.Solucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=150
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Venta.Cliente]
Carpeta=Lista
Clave=Venta.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=121
1=77

[Lista.Venta.Situacion]
Carpeta=Lista
Clave=Venta.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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
NombreDesplegar=&Imprimir
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
NombreDesplegar=&Presentación preliminar
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

[Acciones.Mostrar]
Nombre=Mostrar 
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Mostrar
Mostrar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Venta.Cliente
Venta.Cliente=Venta.Situacion
Venta.Situacion=ServicioTarea.Tarea
ServicioTarea.Tarea=ServicioTarea.Problema
ServicioTarea.Problema=ServicioTarea.Solucion
ServicioTarea.Solucion=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=PENDIENTE
PENDIENTE=CONFIRMAR
CONFIRMAR=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)
