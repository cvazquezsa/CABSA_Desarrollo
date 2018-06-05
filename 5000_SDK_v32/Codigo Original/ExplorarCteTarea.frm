[Forma]
Clave=ExplorarCteTarea
Nombre=Explorar Tareas - Clientes
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=216
PosicionInicialArriba=280
PosicionInicialAltura=456
PosicionInicialAncho=848
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Info.Agente
PosicionInicialAlturaCliente=429

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
Vista=CteTarea
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
CarpetaVisible=S
IconosSubTitulo=<T>Cliente<T>
ListaEnCaptura=(Lista)
ListaOrden=(Lista)
FiltroFechas=S
FiltroFechasCampo=CuentaTarea.Vencimiento
FiltroFechasDefault=Vencido
FiltroFechasVencimiento=S
BusquedaRapida=S
BusquedaAncho=20
BusquedaEnLinea=S
BusquedaInicializar=S
BusquedaRespetarControles=S
PestanaOtroNombre=S
PestanaNombre=Clientes
FiltroGrupo1=Cte.Tipo
FiltroGrupo2=Cte.Cliente
FiltroTodo=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=CteTarea:Cte.Cliente
FiltroGeneral=CuentaTarea.Estado <> <T>Completada<T> <BR>{Si(ConDatos(Info.Agente), <T>AND (Cte.Agente=<T>+Comillas(Info.Agente)+<T> OR Cte.AgenteServicio=<T>+Comillas(Info.Agente)+<T>)<T>, <T><T>)}

[Lista.Cte.Nombre]
Carpeta=Lista
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CuentaTarea.Tarea]
Carpeta=Lista
Clave=CuentaTarea.Tarea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CuentaTarea.Estado]
Carpeta=Lista
Clave=CuentaTarea.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CuentaTarea.Fecha]
Carpeta=Lista
Clave=CuentaTarea.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CuentaTarea.Vencimiento]
Carpeta=Lista
Clave=CuentaTarea.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=104
1=129

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

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Tareas]
Nombre=Tareas
Boton=70
NombreEnBoton=S
NombreDesplegar=&Tareas
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CuentaTarea
Activo=S
Visible=S
ConCondicion=S
Antes=S
Multiple=S
ListaAccionesMultiples=CuentaTarea<BR>ActualizarTareas
EjecucionCondicion=ConDatos(CteTarea:Cte.Cliente)
AntesExpresiones=Asigna(Info.Rama, <T>CXC<T>)<BR>Asigna(Info.Cuenta, CteTarea:Cte.Cliente)<BR>Asigna(Info.Descripcion, CteTarea:Cte.Nombre)

[Acciones.Asunto]
Nombre=Asunto
Boton=0
NombreDesplegar=Ver Asunto
EnMenu=S
TipoAccion=Expresion
Visible=S
Activo=S
Expresion=VerComentario(CteTarea:Cte.Nombre+<T> - <T>+CteTarea:CuentaTarea.Tarea, CteTarea:CuentaTarea.Asunto)
ConCondicion=S
EjecucionCondicion=ConDatos(CteTarea:Cte.Cliente)

[Acciones.Tareas.Tareas]
Nombre=Tareas
Boton=0
TipoAccion=Formas
ClaveAccion=CuentaTarea
Activo=S
Visible=S

[Acciones.Tareas.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Tareas.CuentaTarea]
Nombre=CuentaTarea
Boton=0
TipoAccion=Formas
ClaveAccion=CuentaTarea
Activo=S
Visible=S

[Acciones.Tareas.ActualizarTareas]
Nombre=ActualizarTareas
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Express.CteExpress]
Nombre=CteExpress
Boton=0
TipoAccion=Formas
ClaveAccion=CteExpress
Activo=S
Visible=S

[Acciones.Express.ActualizarCteExpress]
Nombre=ActualizarCteExpress
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Arbol
Activo=S
Visible=S
Carpeta=(Carpeta principal)
ConCondicion=S
EjecucionCondicion=ConDatos(Info.Cliente)

[Acciones.Bitacora]
Nombre=Bitacora
Boton=56
NombreDesplegar=&Bitácora
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CtaBitacora
Activo=S
ConCondicion=S
Antes=S
Visible=S
NombreEnBoton=S
EjecucionCondicion=ConDatos(CteTarea:Cte.Cliente)
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.Tipo, CteTarea:Cte.Tipo)<BR>Asigna(Info.Cuenta, CteTarea:Cte.Cliente)<BR>Asigna(Info.Descripcion, CteTarea:Cte.Nombre)<BR>Asigna(Info.PuedeEditar, Verdadero)

[Acciones.ExplorarCte]
Nombre=ExplorarCte
Boton=51
NombreEnBoton=S
NombreDesplegar=&Lista Clientes
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ExplorarCteTareaLista
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Lista<BR>Actualizar Forma

[Acciones.ExplorarCte.Lista]
Nombre=Lista
Boton=0
TipoAccion=Formas
ClaveAccion=ExplorarCteTareaLista
Activo=S
Visible=S

[Acciones.ExplorarCte.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Arbol
Activo=S
Visible=S
Carpeta=(Carpeta principal)

[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=&Actualizar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
EspacioPrevio=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Tareas
Tareas=Bitacora
Bitacora=ExplorarCte
ExplorarCte=Campos
Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Cte.Nombre
Cte.Nombre=CuentaTarea.Tarea
CuentaTarea.Tarea=CuentaTarea.Estado
CuentaTarea.Estado=CuentaTarea.Fecha
CuentaTarea.Fecha=CuentaTarea.Vencimiento
CuentaTarea.Vencimiento=(Fin)

[Lista.ListaOrden]
(Inicio)=CuentaTarea.Vencimiento<TAB>(Acendente)
CuentaTarea.Vencimiento<TAB>(Acendente)=CuentaTarea.Fecha<TAB>(Acendente)
CuentaTarea.Fecha<TAB>(Acendente)=(Fin)

[Lista.ListaAcciones]
(Inicio)=Asunto
Asunto=Actualizar
Actualizar=(Fin)
