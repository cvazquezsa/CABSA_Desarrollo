[Forma]
Clave=SoporteTarea
Nombre=<T>Tareas Pendientes<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=148
PosicionInicialArriba=146
PosicionInicialAltura=383
PosicionInicialAncho=728
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSeccion1=50
VentanaExclusiva=S
VentanaEscCerrar=
PosicionColumna1=47
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
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Lista
OtroOrden=S
ListaOrden=(Lista)
HojaMantenerSeleccion=S
FiltroPredefinido1=
FiltroPredefinido2=
FiltroPredefinido3=
HojaPermiteInsertar=S
BusquedaRapidaControles=S
FiltroUsuarios=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroUsuarioDefault=(Usuario)
FiltroFechasCampo=MovTarea.Fecha
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaAjustarColumnas=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=Soporte.Empresa=<T>{Empresa}<T> AND <BR>Soporte.Estatus IN (<T>PENDIENTE<T>, <T>ALTAPRIORIDAD<T>, <T>PRIORIDADBAJA<T>)

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
Tarea=181
Diagnostico=164
Revision=604
Estado=149
Mov=124
MovID=64
MovNombre=124

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
Boton=3
NombreDesplegar=Guardar Cambios
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
EnBarraHerramientas=S
EspacioPrevio=S

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
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Usuario.Nombre]
Carpeta=Detalle
Clave=Usuario.Nombre
Editar=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Abrir).MovTarea.Tarea]
Carpeta=(Carpeta Abrir)
Clave=MovTarea.Tarea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).TareaEstado.Estado]
Carpeta=(Carpeta Abrir)
Clave=TareaEstado.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Columnas]
0=40
1=680

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.MovNombre]
Carpeta=Lista
Clave=MovNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar
Guardar=Buscar
Buscar=Navegador
Navegador=Detalles
Detalles=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=MovTarea.Tarea
MovTarea.Tarea=MovNombre
MovNombre=(Fin)

[Lista.ListaOrden]
(Inicio)=TareaEstado.Orden<TAB>(Acendente)
TareaEstado.Orden<TAB>(Acendente)=MovTarea.Fecha<TAB>(Acendente)
MovTarea.Fecha<TAB>(Acendente)=MovTarea.RenglonID<TAB>(Acendente)
MovTarea.RenglonID<TAB>(Acendente)=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=MovTarea.Tarea
MovTarea.Tarea=MovTarea.Problema
MovTarea.Problema=MovTarea.Solucion
MovTarea.Solucion=MovTarea.Estado
MovTarea.Estado=MovTarea.Fecha
MovTarea.Fecha=MovTarea.Usuario
MovTarea.Usuario=Usuario.Nombre
Usuario.Nombre=MovTarea.FechaEstimada
MovTarea.FechaEstimada=MovTarea.FechaConclusion
MovTarea.FechaConclusion=(Fin)
