[Forma]
Clave=CteMovTarea
Nombre=<T>Tareas - Movimientos del Cliente<T>
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=113
PosicionInicialArriba=135
PosicionInicialAltura=296
PosicionInicialAncho=798
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Cuenta, Info.Descripcion)
VentanaEscCerrar=S
VentanaExclusiva=S
PosicionInicialAlturaCliente=464

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteMovTarea
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
OtroOrden=S
ListaOrden=CteMovTarea.Fecha<TAB>(Acendente)
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Automático
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Fecha/Hora<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Evento(s)
ListaEnCaptura=(Lista)
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroProyectos=S
FiltroSucursales=S
FiltroUENs=S
FiltroUENsCampo=CteMovTarea.UEN
FiltroUsuarioDefault=(Todos)
FiltroFechasCampo=CteMovTarea.Fecha
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroFechasDefault=Este Mes
FiltroEstatus=S
FiltroSituacion=S
FiltroSituacionTodo=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=(Todos)
FiltroAplicaEn=CteMovTarea.Estado
FiltroAutoCampo=CteMovTarea.Estado
FiltroAutoValidar=CteMovTarea.Estado
FiltroEstilo=Directorio
IconosNombre=FechaEnTexto(CteMovTarea:CteMovTarea.Fecha, <T>dd/mmm/aaaa hh:nn am/pm<T>)
FiltroGeneral=CteMovTarea.Empresa=<T>{Empresa}<T> AND CteMovTarea.Cliente=<T>{Info.Cuenta}<T>

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Evento=429
Fecha=117
0=136
1=126

[Acciones.Agregar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Lista.Movimiento]
Carpeta=Lista
Clave=Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=Propiedades
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(CteMovTarea:CteMovTarea.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, CteMovTarea:CteMovTarea.Modulo)<BR>Asigna(Info.ID, CteMovTarea:CteMovTarea.ID)
Visible=S

[Lista.CteMovTarea.Tarea]
Carpeta=Lista
Clave=CteMovTarea.Tarea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Propiedades
Propiedades=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Movimiento
Movimiento=CteMovTarea.Tarea
CteMovTarea.Tarea=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=(Fin)
