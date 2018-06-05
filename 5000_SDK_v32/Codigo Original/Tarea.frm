[Forma]
Clave=Tarea
Nombre=Tareas
Icono=62
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=541
PosicionInicialArriba=271
PosicionInicialAlturaCliente=623
PosicionInicialAncho=837
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Si(Info.ID>0, Lista(Info.Mov, Info.MovID, Info.Nombre), Lista(Info.Cliente, Info.Proveedor, Info.Agente, Info.Personal, Info.Proyecto, Info.UEN, Info.Reporte, Info.Nombre))

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
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
IconosSubTitulo=<T>Asunto<T>
ElementosPorPagina=200
IconosSeleccionMultiple=S
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

IconosNombre=Tarea:Tarea.Asunto
FiltroGeneral=Tarea.Empresa=<T>{Empresa}<T><BR>{Si<BR>  ConDatos(Info.ID) y ConDatos(Info.Modulo)<BR>Entonces<BR> <T> AND Tarea.Modulo=<T>+Comillas(Info.Modulo)+<T> AND Tarea.ModuloID=<T>+Info.ID<BR>Sino<BR>  Si(ConDatos(Info.Cliente),   <T> AND Tarea.Cliente=<T>+Comillas(Info.Cliente), <T><T>)+<BR>  Si(ConDatos(Info.Prospecto), <T> AND Tarea.Prospecto=<T>+Comillas(Info.Prospecto), <T><T>)+<BR>  Si(ConDatos(Info.Proveedor), <T> AND Tarea.Proveedor=<T>+Comillas(Info.Proveedor), <T><T>)+<BR>  Si(ConDatos(Info.Agente),    <T> AND Tarea.Agente=<T>+Comillas(Info.Agente), <T><T>)+<BR>  Si(ConDatos(Info.Personal),  <T> AND Tarea.Personal=<T>+Comillas(Info.Personal), <T><T>)+<BR>  Si(ConDatos(Info.Proyecto),  <T> AND Tarea.Proyecto=<T>+Comillas(Info.Proyecto), <T><T>)+<BR>  Si(Info.UEN>0,               <T> AND Tarea.UEN=<T>+Info.UEN, <T><T>)+<BR>  Si(ConDatos(Info.Reporte),   <T> AND Tarea.Reporte=<T>+Comillas(Info.Reporte), <T><T>)<BR>Fin<BR>}
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
0=390
1=57

2=-2
3=-2
4=-2
5=-2
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

[Acciones.Editar]
Nombre=Editar
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalle
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
ConCondicion=S
Visible=S
Activo=S
EjecucionCondicion=Si<BR>  ConDatos(Tarea:Tarea.ID)<BR>Entonces<BR>  Asigna(Info.TareaID, Tarea:Tarea.ID)<BR>  Forma(<T>TareaEditar<T>)<BR>Sino<BR>  Falso<BR>Fin

[Acciones.Nueva]
Nombre=Nueva
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nueva
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
ConCondicion=S
Visible=S
EspacioPrevio=S
ActivoCondicion=Info.PuedeEditar
EjecucionCondicion=Forma(<T>TareaNueva<T>)

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

[Acciones.CompletarSeleccion]
Nombre=CompletarSeleccion
Boton=7
NombreEnBoton=S
NombreDesplegar=&Completar Selección
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
Expresion=RegistrarSeleccionID(<T>Lista<T>)<BR>EjecutarSQL(<T>spTareasCompletarSeleccion :nEstacion<T>, EstacionTrabajo) <BR>Forma.ActualizarVista
ActivoCondicion=Info.PuedeEditar

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

[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreDesplegar=&Actualizar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S
EspacioPrevio=S

[Lista.Tarea.Tarea]
Carpeta=Lista
Clave=Tarea.Tarea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[Lista.ListaEnCaptura]
(Inicio)=Tarea.Tarea
Tarea.Tarea=Tarea.Tipo
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

















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Nueva
Nueva=Editar
Editar=CompletarSeleccion
CompletarSeleccion=Actualizar
Actualizar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)
