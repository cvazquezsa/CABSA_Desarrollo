[Forma]
Clave=MovTarea
Nombre=e(<T>Tareas<T>)+<T> - <T>+Info.Mov+<T> <T>+Info.MovID
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=326
PosicionInicialArriba=278
PosicionInicialAltura=383
PosicionInicialAncho=627
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
PosicionInicialAlturaCliente=441
AutoGuardar=S

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTarea
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=MovTarea.Tarea
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
FiltroAutoCampo=MovTarea.Estado
FiltroTodoFinal=S
FiltroAutoValidar=TareaEstado.NombrePlural
FiltroAutoOrden=TareaEstado.Orden
HojaPermiteInsertar=S
FiltroGeneral=MovTarea.ID={Info.ID}

[Lista.MovTarea.Tarea]
Carpeta=Lista
Clave=MovTarea.Tarea
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

[Detalle.MovTarea.Problema]
Carpeta=Detalle
Clave=MovTarea.Problema
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51x6
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.MovTarea.Solucion]
Carpeta=Detalle
Clave=MovTarea.Solucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51x6
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.MovTarea.Estado]
Carpeta=Detalle
Clave=MovTarea.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.MovTarea.Fecha]
Carpeta=Detalle
Clave=MovTarea.Fecha
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[Detalle.MovTarea.Tarea]
Carpeta=Detalle
Clave=MovTarea.Tarea
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
ClaveAccion=MovTareaD
DespuesGuardar=S
GuardarAntes=S
EjecucionCondicion=ConDatos(MovTarea:MovTarea.Tarea)
AntesExpresiones=Asigna(Info.ID, MovTarea:MovTarea.ID)<BR>Asigna(Info.RenglonID, MovTarea:MovTarea.RenglonID)<BR>Asigna(Info.Descripcion, MovTarea:MovTarea.Tarea)

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
Vista=MovTarea
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
Expresion=Asigna(Info.Tarea, MovTarea:MovTarea.Tarea)<BR>Asigna(Info.Problema, MovTarea:MovTarea.Problema)<BR>Asigna(Info.Solucion, MovTarea:MovTarea.Solucion)<BR>Si<BR>  Forma(<T>MovTareaLista<T>)<BR>Entonces<BR>  Asigna(MovTarea:MovTarea.Problema, Info.Problema)<BR>  Asigna(MovTarea:MovTarea.Solucion, Info.Solucion)<BR>Fin

[Detalle.MovTarea.FechaEstimada]
Carpeta=Detalle
Clave=MovTarea.FechaEstimada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.MovTarea.FechaConclusion]
Carpeta=Detalle
Clave=MovTarea.FechaConclusion
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.MovTarea.Usuario]
Carpeta=Detalle
Clave=MovTarea.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Detalle.Usuario.Nombre]
Carpeta=Detalle
Clave=Usuario.Nombre
Editar=N
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Plata
ColorFuente=Negro

[Detalle.MovTarea.Tiempo]
Carpeta=Detalle
Clave=MovTarea.Tiempo
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Comentarios]
Nombre=Comentarios
Boton=47
NombreDesplegar=&Comentarios
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovTareaComentarios
Activo=S
Visible=S
EspacioPrevio=S
Antes=S
AntesExpresiones=Asigna(Info.RenglonID, MovTarea:MovTarea.RenglonID)
DespuesGuardar=S

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar Orden
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
GuardarAntes=S
AntesExpresiones=Forma(<T>MovTareaOrdenar<T>)
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
TareaEstado.Orden<TAB>(Acendente)=MovTarea.Orden<TAB>(Acendente)
MovTarea.Orden<TAB>(Acendente)=MovTarea.Fecha<TAB>(Acendente)
MovTarea.Fecha<TAB>(Acendente)=MovTarea.RenglonID<TAB>(Acendente)
MovTarea.RenglonID<TAB>(Acendente)=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=MovTarea.Tarea
MovTarea.Tarea=MovTarea.Problema
MovTarea.Problema=MovTarea.Solucion
MovTarea.Solucion=MovTarea.Estado
MovTarea.Estado=MovTarea.Fecha
MovTarea.Fecha=MovTarea.FechaEstimada
MovTarea.FechaEstimada=MovTarea.FechaConclusion
MovTarea.FechaConclusion=MovTarea.Usuario
MovTarea.Usuario=Usuario.Nombre
Usuario.Nombre=MovTarea.Tiempo
MovTarea.Tiempo=(Fin)
