[Forma]
Clave=TareaLista
Nombre=Tareas
Icono=62
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=93
PosicionInicialArriba=55
PosicionInicialAlturaCliente=623
PosicionInicialAncho=837
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=Si<BR> Version.OutlookTareas y Version.OutlookTareasSincronizar <BR>Entonces<BR>  Si<BR>    Usuario<>SQL(<T>SELECT MIN(Usuario) FROM OutlookNombre WHERE Usuario=:tUsuario AND Estatus=:tEstatus<T>, Usuario, EstatusAlta)<BR>  Entonces<BR>    Error(<T>Falta Definir la Relacion Usuario (Intelisis - Outlook) <T>+Comillas(Usuario))<BR>    AbortarOperacion<BR>  Fin<BR>Fin<BR>Si(Info.PuedeEditar y ConDatos(Info.Modulo) y (Info.ID>0), EjecutarSQL(<T>spTareasPorOmision :tModulo, :nID, :tEmpresa, :tMov, :tUsuario<T>, Info.Modulo, Info.ID, Empresa, Info.Mov, Usuario))

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Tarea
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todas
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNombre=&Vencimiento
CarpetaVisible=S
ListaEnCaptura=(Lista)
FiltroFechas=S
FiltroUsuarioDefault=(Todos)
FiltroFechasCampo=Tarea.Vencimiento
FiltroFechasDefault=(Todo)
FiltroFechasVencimiento=S
BusquedaRapida=S
BusquedaRespetarFiltros=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Tarea<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Tareas
MenuLocal=S
ListaAcciones=(Lista)
FiltroProyectos=S
FiltroUENs=S
FiltroUENsCampo=Tarea.UEN
FiltroAplicaEn=Tarea.Estado
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=TareaEstado
FiltroUsuarios=S
FiltroTodo=S
FiltroTodoFinal=S
OtroOrden=S
ListaOrden=Tarea.Orden<TAB>(Acendente)
IconosNombre=Tarea:Tarea.Tarea
FiltroGeneral=Tarea.Empresa=<T>{Empresa}<T>

[Lista.Tarea.Estado]
Carpeta=Lista
Clave=Tarea.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Tarea.Prioridad]
Carpeta=Lista
Clave=Tarea.Prioridad
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Tarea.Vencimiento]
Carpeta=Lista
Clave=Tarea.Vencimiento
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Completada=59
Asunto=398
Estado=184
Prioridad=64
Vencimiento=113
0=47
1=381

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

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
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

[Acciones.LocalEditar]
Nombre=LocalEditar
Boton=0
NombreDesplegar=&Detalle
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
ConCondicion=S
Visible=S
ActivoCondicion=no General.PM
EjecucionCondicion=Si<BR>  ConDatos(Tarea:Tarea.ID)<BR>Entonces<BR>  Asigna(Info.TareaID, Tarea:Tarea.ID)<BR>  Forma(<T>TareaEditar<T>)<BR>Sino<BR>  Falso<BR>Fin

[Acciones.LocalImprimir]
Nombre=LocalImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.LocalBitacora]
Nombre=LocalBitacora
Boton=0
NombreDesplegar=&Bitácora
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=TareaBitacora
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.TareaID, Tarea:Tarea.ID)
Visible=S

[Acciones.LocalExcel]
Nombre=LocalExcel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.LocalPersonalizar]
Nombre=LocalPersonalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.LocalPreliminar]
Nombre=LocalPreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
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
EspacioPrevio=S

[Acciones.LocalQuitar]
Nombre=LocalQuitar
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Lista.Tarea.Tipo]
Carpeta=Lista
Clave=Tarea.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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

[Lista.Tarea.Asunto]
Carpeta=Lista
Clave=Tarea.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Tarea.Asunto
Tarea.Asunto=Tarea.Tipo
Tarea.Tipo=Tarea.Estado
Tarea.Estado=Tarea.Prioridad
Tarea.Prioridad=Tarea.Vencimiento
Tarea.Vencimiento=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalEditar
LocalEditar=LocalBitacora
LocalBitacora=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=LocalImprimir
LocalImprimir=LocalPreliminar
LocalPreliminar=LocalExcel
LocalExcel=LocalPersonalizar
LocalPersonalizar=(Fin)
