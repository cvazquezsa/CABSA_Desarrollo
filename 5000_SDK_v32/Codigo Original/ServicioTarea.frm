[Forma]
Clave=ServicioTarea
Nombre=e(<T>Tareas<T>)+<T> - <T>+Info.Mov+<T> <T>+Info.MovID
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=197
PosicionInicialArriba=151
PosicionInicialAltura=383
PosicionInicialAncho=629
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSeccion1=50
VentanaExclusiva=S
VentanaEscCerrar=
PosicionColumna1=39
PosicionSeccion2=66
PosicionInicialAlturaCliente=431
AutoGuardar=S

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ServicioTarea
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ServicioTarea.Tarea
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=20
FiltroTodo=S
FiltroTodoNombre=Todas
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Automático
PestanaOtroNombre=S
PestanaNombre=Lista
OtroOrden=S
ListaOrden=(Lista)
HojaMantenerSeleccion=S
FiltroPredefinido1=No comenzadas<BR>En curso<BR>Otra persona<BR>Aplazadas<BR>Completadas
FiltroPredefinido2=Estado=<T>No comenzada<T><BR>Estado=<T>En curso<T><BR>Estado=<T>A la espera de otra persona<T><BR>Estado=<T>Aplazada<T><BR>Estado=<T>Completada<T>
FiltroEstilo=Folder (1 línea)
FiltroPredefinido3=RenglonID<BR>RenglonID<BR>RenglonID<BR>RenglonID<BR>RenglonID
FiltroAutoCampo=ServicioTarea.Estado
FiltroTodoFinal=S
FiltroAutoValidar=TareaEstado.NombrePlural
FiltroAutoOrden=TareaEstado.Orden
HojaPermiteInsertar=S
FiltroGeneral=ServicioTarea.ID={Info.ID}

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

[Lista.Columnas]
Concluido=53
Tarea=201
Diagnostico=164
Revision=604
Estado=149

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar tarea
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nueva tarea
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Detalle.ServicioTarea.Problema]
Carpeta=Detalle
Clave=ServicioTarea.Problema
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51x6
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServicioTarea.Solucion]
Carpeta=Detalle
Clave=ServicioTarea.Solucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51x6
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServicioTarea.Estado]
Carpeta=Detalle
Clave=ServicioTarea.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServicioTarea.Fecha]
Carpeta=Detalle
Clave=ServicioTarea.Fecha
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[Detalle.ServicioTarea.Tarea]
Carpeta=Detalle
Clave=ServicioTarea.Tarea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Detalles]
Nombre=Detalles
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalles
EnBarraHerramientas=S
TipoAccion=Formas
ConCondicion=S
Antes=S
ClaveAccion=ServicioTareaD
DespuesGuardar=S
GuardarAntes=S
EjecucionCondicion=ConDatos(ServicioTarea:ServicioTarea.Tarea)
AntesExpresiones=Asigna(Info.ID, ServicioTarea:ServicioTarea.ID)<BR>Asigna(Info.RenglonID, ServicioTarea:ServicioTarea.RenglonID)<BR>Asigna(Info.Descripcion, ServicioTarea:ServicioTarea.Tarea)

[Acciones.Guardar]
Nombre=Guardar
Boton=0
NombreDesplegar=Guardar Cambios
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Detalle]
Estilo=Ficha
Clave=Detalle
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ServicioTarea
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Buscar]
Nombre=Buscar
Boton=51
NombreDesplegar=&Problemas y Soluciones
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
NombreEnBoton=S
EspacioPrevio=S
Expresion=Asigna(Info.Tarea, ServicioTarea:ServicioTarea.Tarea)<BR>Asigna(Info.Problema, ServicioTarea:ServicioTarea.Problema)<BR>Asigna(Info.Solucion, ServicioTarea:ServicioTarea.Solucion)<BR>Si<BR>  Forma(<T>ServicioTareaLista<T>)<BR>Entonces<BR>  Asigna(ServicioTarea:ServicioTarea.Problema, Info.Problema)<BR>  Asigna(ServicioTarea:ServicioTarea.Solucion, Info.Solucion)<BR>Fin

[Detalle.ServicioTarea.FechaEstimada]
Carpeta=Detalle
Clave=ServicioTarea.FechaEstimada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServicioTarea.FechaConclusion]
Carpeta=Detalle
Clave=ServicioTarea.FechaConclusion
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServicioTarea.Tiempo]
Carpeta=Detalle
Clave=ServicioTarea.Tiempo
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ServicioTarea.Usuario]
Carpeta=Detalle
Clave=ServicioTarea.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Usuario.Nombre]
Carpeta=Detalle
Clave=Usuario.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Comentarios]
Nombre=Comentarios
Boton=47
NombreDesplegar=Comentarios
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ServicioTareaComentarios
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Asigna(Info.RenglonID, ServicioTarea:ServicioTarea.RenglonID)

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar Orden
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Antes=S
Visible=S
GuardarAntes=S
AntesExpresiones=Forma(<T>ServicioTareaOrdenar<T>)
DespuesGuardar=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Cerrar
Cerrar=Nuevo
Nuevo=Eliminar
Eliminar=Comentarios
Comentarios=Buscar
Buscar=Ordenar
Ordenar=Navegador
Navegador=Detalles
Detalles=(Fin)

[Lista.ListaOrden]
(Inicio)=TareaEstado.Orden<TAB>(Acendente)
TareaEstado.Orden<TAB>(Acendente)=ServicioTarea.Orden<TAB>(Acendente)
ServicioTarea.Orden<TAB>(Acendente)=ServicioTarea.Fecha<TAB>(Acendente)
ServicioTarea.Fecha<TAB>(Acendente)=ServicioTarea.RenglonID<TAB>(Acendente)
ServicioTarea.RenglonID<TAB>(Acendente)=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=ServicioTarea.Tarea
ServicioTarea.Tarea=ServicioTarea.Problema
ServicioTarea.Problema=ServicioTarea.Solucion
ServicioTarea.Solucion=ServicioTarea.Estado
ServicioTarea.Estado=ServicioTarea.Fecha
ServicioTarea.Fecha=ServicioTarea.FechaEstimada
ServicioTarea.FechaEstimada=ServicioTarea.FechaConclusion
ServicioTarea.FechaConclusion=ServicioTarea.Usuario
ServicioTarea.Usuario=Usuario.Nombre
Usuario.Nombre=ServicioTarea.Tiempo
ServicioTarea.Tiempo=(Fin)
