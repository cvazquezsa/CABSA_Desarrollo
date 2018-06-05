[Forma]
Clave=CtaSituacionProg
Nombre=<T>Situaciones Programadas<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=166
PosicionInicialArriba=172
PosicionInicialAltura=416
PosicionInicialAncho=691
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSeccion1=33
PosicionSeccion2=66
VentanaBloquearAjuste=
ExpresionesAlMostrar=
PosicionInicialAlturaCliente=389

[Lista]
Estilo=Hoja
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CtaSituacionProg
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
HojaMantenerSeleccion=S
Filtros=S
OtroOrden=S
ListaOrden=CtaSituacionProg.Cuenta<TAB>(Acendente)
FiltroPredefinido1=
FiltroPredefinido2=
PermiteEditar=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=TipoCuenta
FiltroAplicaEn=CtaSituacionProg.TipoCuenta
FiltroTipo=Automático
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroTodoFinal=S
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=18
FiltroPredefinido=S
FiltroAutoCampo=CtaSituacionProg.TipoCuenta
FiltroAutoValidar=CtaSituacionProg.TipoCuenta
FiltroEstilo=Folder (1 línea)
HojaAjustarColumnas=S
HojaPermiteEliminar=S
HojaConfirmarEliminar=S
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ACTIVO
FiltroFechasCampo=CtaSituacionProg.Fecha
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S

[Lista.CtaSituacionProg.TipoCuenta]
Carpeta=Lista
Clave=CtaSituacionProg.TipoCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
IgnoraFlujo=S

[Lista.CtaSituacionProg.Cuenta]
Carpeta=Lista
Clave=CtaSituacionProg.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Codigo=130
SubCodigo=75
TipoCuenta=78
Cuenta=121
Cantidad=49
Unidad=69
SerieLote=97
Fecha=94
Situacion=262
Estatus=94

[Detalles.CtaSituacionProg.TipoCuenta]
Carpeta=Detalles
Clave=CtaSituacionProg.TipoCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=S

[Detalles.CtaSituacionProg.Cuenta]
Carpeta=Detalles
Clave=CtaSituacionProg.Cuenta
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
EnMenu=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
ConfirmarAntes=S
EspacioPrevio=
Menu=&Archivo
EnMenu=S

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
EnMenu=S
NombreEnBoton=S
EspacioPrevio=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Visible=S
EspacioPrevio=S
ActivoCondicion=Usuario.EnviarExcel

[Lista.CtaSituacionProg.Fecha]
Carpeta=Lista
Clave=CtaSituacionProg.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtaSituacionProg.Situacion]
Carpeta=Lista
Clave=CtaSituacionProg.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtaSituacionProg.Estatus]
Carpeta=Lista
Clave=CtaSituacionProg.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar
Guardar=Nuevo
Nuevo=Eliminar
Eliminar=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CtaSituacionProg.TipoCuenta
CtaSituacionProg.TipoCuenta=CtaSituacionProg.Cuenta
CtaSituacionProg.Cuenta=CtaSituacionProg.Fecha
CtaSituacionProg.Fecha=CtaSituacionProg.Situacion
CtaSituacionProg.Situacion=CtaSituacionProg.Estatus
CtaSituacionProg.Estatus=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ACTIVO
ACTIVO=INACTIVO
INACTIVO=PROCESADO
PROCESADO=(Fin)
