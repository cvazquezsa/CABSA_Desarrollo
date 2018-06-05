[Forma]
Clave=CuentaTarea
Nombre=<T>Tareas - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialAltura=392
PosicionInicialAncho=765
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=
PosicionInicialIzquierda=129
PosicionInicialArriba=184
PosicionColumna1=40
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=365
Comentarios=Lista(Info.Cuenta, Info.Descripcion)

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CuentaTarea
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=CuentaTarea.Tarea
CarpetaVisible=S
Filtros=S
OtroOrden=S
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroAutoCampo=CuentaTarea.Estado
FiltroEstilo=Folder (1 línea)
FiltroAncho=30
FiltroTodo=S
FiltroTodoNombre=Todas
FiltroTodoFinal=S
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Automático
HojaMantenerSeleccion=S
FiltroAutoValidar=TareaEstado.NombrePlural
FiltroAutoOrden=TareaEstado.Orden
FiltroGeneral=CuentaTarea.Rama=<T>{Info.Rama}<T> AND<BR>CuentaTarea.Cuenta=<T>{Info.Cuenta}<T>

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

[Lista.Columnas]
Tarea=263

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CuentaTarea
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.CuentaTarea.Estado]
Carpeta=Ficha
Clave=CuentaTarea.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CuentaTarea.Fecha]
Carpeta=Ficha
Clave=CuentaTarea.Fecha
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CuentaTarea.Asunto]
Carpeta=Ficha
Clave=CuentaTarea.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62x15
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nueva tarea
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar tarea
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S

[Ficha.CuentaTarea.Tarea]
Carpeta=Ficha
Clave=CuentaTarea.Tarea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
Efectos=[Negritas]
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CuentaTarea.Vencimiento]
Carpeta=Ficha
Clave=CuentaTarea.Vencimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=(Fin)

[Lista.ListaOrden]
(Inicio)=CuentaTarea.Vencimiento<TAB>(Acendente)
CuentaTarea.Vencimiento<TAB>(Acendente)=CuentaTarea.Fecha<TAB>(Acendente)
CuentaTarea.Fecha<TAB>(Acendente)=CuentaTarea.RenglonID<TAB>(Acendente)
CuentaTarea.RenglonID<TAB>(Acendente)=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=CuentaTarea.Tarea
CuentaTarea.Tarea=CuentaTarea.Asunto
CuentaTarea.Asunto=CuentaTarea.Estado
CuentaTarea.Estado=CuentaTarea.Fecha
CuentaTarea.Fecha=CuentaTarea.Vencimiento
CuentaTarea.Vencimiento=(Fin)
