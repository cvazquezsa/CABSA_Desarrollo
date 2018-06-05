[Forma]
Clave=EmbarqueAsignar
Nombre=Asignar Embarques
Icono=48
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Pendientes
PosicionInicialIzquierda=1580
PosicionInicialArriba=25
PosicionInicialAltura=516
PosicionInicialAncho=919
PosicionColumna1=61
PosicionSeccion1=57
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(<T>Ruta: <T>+Info.Ruta, <T>Vehículo: <T>+Info.Vehiculo, <T>Peso: <T>+ NumEnTexto(Info.Peso, <T>#,.##<T>), <T>Volumen: <T>+ NumEnTexto(Info.Volumen, <T>#,.##<T>) )
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=489

PosicionSec1=242
[Pendientes]
Estilo=Iconos
Clave=Pendientes
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmbarqueMov
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Pendientes
IconosSeleccionMultiple=S
MenuLocal=S
ListaAcciones=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroAutoCampo=EmbarqueMov.Ruta
FiltroAutoValidar=EmbarqueMov.Ruta
FiltroAncho=20
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todas las Rutas
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por grupos)
FiltroTodoFinal=S
FiltroAplicaEn=EmbarqueMov.Ruta
OtroOrden=S
ListaOrden=EmbarqueMov.ID<TAB>(Acendente)
PermiteLocalizar=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroGrupo1=EmbarqueMov.Ruta
FiltroValida1=EmbarqueMov.Ruta
FiltroGrupo2=EmbarqueMov.Modulo
FiltroValida2=Modulo.Nombre
FiltroGrupo3=EmbarqueMov.Almacen
FiltroValida3=EmbarqueMov.Almacen
FiltroEmpresas=S
FiltroIgnorarEmpresas=S
FiltroSucursales=S
FiltroSucursalesTodasPorOmision=S

IconosNombre=EmbarqueMov:EmbarqueMov.Mov+ <T> <T> +EmbarqueMov:EmbarqueMov.MovID
FiltroGeneral=EmbarqueMov.MovEstatus<><T>CANCELADO<T> AND <BR>EmbarqueMov.AsignadoID = {Si(Info.AntecedenteID = 0, <T>NULL<T>, Info.AntecedenteID)}<BR>AND EmbarqueMov.Modulo<><T>CXC<T>
FuenteBusqueda={MS Sans Serif, 8, Negro, []}
[Pendientes.EmbarqueMov.Zona]
Carpeta=Pendientes
Clave=EmbarqueMov.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Pendientes.EmbarqueMov.Ruta]
Carpeta=Pendientes
Clave=EmbarqueMov.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Pendientes.EmbarqueMov.Accion]
Carpeta=Pendientes
Clave=EmbarqueMov.Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Pendientes.EmbarqueMov.Peso]
Carpeta=Pendientes
Clave=EmbarqueMov.Peso
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Pendientes.EmbarqueMov.Volumen]
Carpeta=Pendientes
Clave=EmbarqueMov.Volumen
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Asignado]
Estilo=Iconos
Clave=Asignado
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=EmbarqueAsignado
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosSubTitulo=<T>Movimiento<T>
PestanaOtroNombre=S
PestanaNombre=Asignados
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
MenuLocal=S
ListaAcciones=(Lista)
OtroOrden=S
ListaOrden=EmbarqueD.Orden<TAB>(Acendente)
IconosCambiarOrden=S
IconosNombre=EmbarqueAsignado:EmbarqueMov.Mov+<T> <T>+EmbarqueAsignado:EmbarqueMov.MovID
FiltroGeneral=EmbarqueD.ID={Info.ID}

[Pendientes.Columnas]
0=174
1=61

2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
9=-2
10=221
[Asignado.Columnas]
0=109
1=43

2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
9=-2
10=-2
11=-2
[Pendientes.ImporteTotal]
Carpeta=Pendientes
Clave=ImporteTotal
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Asignado.ImporteTotal]
Carpeta=Asignado
Clave=ImporteTotal
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Asignar]
Nombre=Asignar
Boton=54
NombreEnBoton=S
NombreDesplegar=Asignar &Selección
EnBarraHerramientas=S
EspacioPrevio=S
Activo=S
Visible=S
TipoAccion=Expresion
Expresion=Si<BR>  CuantosSeleccionID(<T>Pendientes<T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>Pendientes<T>)<BR>  EjecutarSQL(<T>spEmbarqueAsignar :nSucursal, :nEstacion, :nID<T>, Sucursal, EstacionTrabajo, Info.ID)<BR>  ActualizarForma<BR>Fin

[Acciones.PendientesSeleccionarTodo]
Nombre=PendientesSeleccionarTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.PendienteMostrarCampos]
Nombre=PendienteMostrarCampos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Pendientes.EmbarqueMov.NombreEnvio]
Carpeta=Pendientes
Clave=EmbarqueMov.NombreEnvio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Acciones.AsignadoQuitar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=RegistrarSeleccionID(<T>Asignado<T>)<BR>EjecutarSQL(<T>spEmbarqueDesAsignar :nEstacion, :nID, :nAntecedenteID<T>, EstacionTrabajo, Info.ID, Info.AntecedenteID)

[Acciones.AsignadoQuitar.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.PendientesAsignar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=RegistrarSeleccionID(<T>Pendientes<T>)<BR>EjecutarSQL(<T>spEmbarqueAsignar :nSucursal, :nEstacion, :nID<T>, Sucursal, EstacionTrabajo, Info.ID)
Activo=S
Visible=S

[Acciones.PendientesAsignar.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.PendientesAsignar]
Nombre=PendientesAsignar
Boton=0
NombreDesplegar=A&signar selección
Multiple=S
EnMenu=S
ListaAccionesMultiples=Expresion<BR>Actualizar Forma
Activo=S
Visible=S

[Acciones.AsignadoQuitar]
Nombre=AsignadoQuitar
Boton=0
NombreDesplegar=&Quitar
Multiple=S
EnMenu=S
ListaAccionesMultiples=Expresion<BR>Actualizar Forma
Activo=S
Visible=S

[Acciones.AsignadoSelecciona]
Nombre=AsignadoSelecciona
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.AsignadoMostrar]
Nombre=AsignadoMostrar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Ordenar<BR>Asignar<BR>Aceptar

[Asignado.EmbarqueD.Orden]
Carpeta=Asignado
Clave=EmbarqueD.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Asignado.EmbarqueMov.Accion]
Carpeta=Asignado
Clave=EmbarqueMov.Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Asignado.EmbarqueMov.NombreEnvio]
Carpeta=Asignado
Clave=EmbarqueMov.NombreEnvio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Asignado.EmbarqueMov.Ruta]
Carpeta=Asignado
Clave=EmbarqueMov.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Asignado.EmbarqueMov.Zona]
Carpeta=Asignado
Clave=EmbarqueMov.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Asignado.EmbarqueMov.OrdenEmbarque]
Carpeta=Asignado
Clave=EmbarqueMov.OrdenEmbarque
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Asignado.EmbarqueMov.Peso]
Carpeta=Asignado
Clave=EmbarqueMov.Peso
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Asignado.EmbarqueMov.Volumen]
Carpeta=Asignado
Clave=EmbarqueMov.Volumen
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Pendientes.EmbarqueMov.Paquetes]
Carpeta=Pendientes
Clave=EmbarqueMov.Paquetes
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Asignado.EmbarqueMov.Paquetes]
Carpeta=Asignado
Clave=EmbarqueMov.Paquetes
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.PendienteExaminar]
Nombre=PendienteExaminar
Boton=0
NombreDesplegar=Examinar Movimiento
EnMenu=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
Expresion=ReportePantalla(ReporteMovPantalla(EmbarqueMov:EmbarqueMov.Modulo, EmbarqueMov:EmbarqueMov.Mov), EmbarqueMov:EmbarqueMov.ModuloID)
ActivoCondicion=ConDatos(EmbarqueMov:EmbarqueMov.ModuloID)

[Acciones.AsignadoExaminar]
Nombre=AsignadoExaminar
Boton=0
NombreDesplegar=Examinar Movimiento
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
Expresion=ReportePantalla(ReporteMovPantalla(EmbarqueAsignado:EmbarqueMov.Modulo, EmbarqueAsignado:EmbarqueMov.Mov), EmbarqueAsignado:EmbarqueMov.ModuloID)
ActivoCondicion=ConDatos(EmbarqueAsignado:EmbarqueMov.ModuloID)

[Acciones.Aceptar.Ordenar]
Nombre=Ordenar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Si<BR>  CuantosListaID(<T>Asignado<T>)>0<BR>Entonces<BR>  RegistrarListaID(<T>Asignado<T>)<BR>  EjecutarSQL(<T>spEmbarqueAsignar :nSucursal, :nEstacion, :nID, 1<T>, Sucursal, EstacionTrabajo, Info.ID)<BR>Fin

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Aceptar.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Expresion
Expresion=Si<BR>  CuantosSeleccionID(<T>Pendientes<T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>Pendientes<T>)<BR>  EjecutarSQL(<T>spEmbarqueAsignar :nSucursal, :nEstacion, :nID<T>, Sucursal, EstacionTrabajo, Info.ID)<BR>Fin
Activo=S
Visible=S

[Acciones.Localizar]
Nombre=Localizar
Boton=73
NombreDesplegar=Localizar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S

[Acciones.CancelarLocal.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=ProcesarSQL(<T>spEmbarqueManual :tEmpresa, :tModulo, :nID, :tMov, :tMovID, :tEstatus, 1<T>, Empresa, Info.Modulo, Info.ID, Info.Mov, Info.MovID, Info.Estatus)
Activo=S
Visible=S

[Acciones.CancelarLocal.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.CancelarLocal]
Nombre=CancelarLocal
Boton=0
NombreDesplegar=&Cancelar Embarque
Multiple=S
EnMenu=S
ConfirmarAntes=S
DialogoMensaje=MovEmbarcarConfirmar
ListaAccionesMultiples=Expresion<BR>Actualizar Vista
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(EmbarqueMov:EmbarqueMov.ID)
AntesExpresiones=Asigna(Info.Descripcion, <T>Cancelar Embarque<T>)<BR>Asigna(Info.Modulo, EmbarqueMov:EmbarqueMov.Modulo)<BR>Asigna(Info.ID, EmbarqueMov:EmbarqueMov.ModuloID)<BR>Asigna(Info.Mov, EmbarqueMov:EmbarqueMov.Mov)<BR>Asigna(Info.MovID, EmbarqueMov:EmbarqueMov.MovID)<BR>Asigna(Info.Estatus, EmbarqueMov:EmbarqueMov.MovEstatus)

[Pendientes.EmbarqueMov.Empresa]
Carpeta=Pendientes
Clave=EmbarqueMov.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Asignado.EmbarqueMov.Empresa]
Carpeta=Asignado
Clave=EmbarqueMov.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.AsignarTodo]
Nombre=AsignarTodo
Boton=55
NombreEnBoton=S
NombreDesplegar=Asignar &Todo
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=SeleccionarTodo(<T>Pendientes<T>) <BR>Si<BR>  CuantosSeleccionID(<T>Pendientes<T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>Pendientes<T>)<BR>  EjecutarSQL(<T>spEmbarqueAsignar :nSucursal, :nEstacion, :nID<T>, Sucursal, EstacionTrabajo, Info.ID)<BR>  ActualizarForma<BR>Fin



[Asignado.ListaEnCaptura]
(Inicio)=EmbarqueD.Orden
EmbarqueD.Orden=EmbarqueMov.Empresa
EmbarqueMov.Empresa=EmbarqueMov.Accion
EmbarqueMov.Accion=EmbarqueMov.NombreEnvio
EmbarqueMov.NombreEnvio=EmbarqueMov.Ruta
EmbarqueMov.Ruta=EmbarqueMov.Zona
EmbarqueMov.Zona=EmbarqueMov.OrdenEmbarque
EmbarqueMov.OrdenEmbarque=EmbarqueMov.Peso
EmbarqueMov.Peso=EmbarqueMov.Volumen
EmbarqueMov.Volumen=EmbarqueMov.Paquetes
EmbarqueMov.Paquetes=ImporteTotal
ImporteTotal=(Fin)

[Asignado.ListaAcciones]
(Inicio)=AsignadoQuitar
AsignadoQuitar=AsignadoSelecciona
AsignadoSelecciona=AsignadoExaminar
AsignadoExaminar=AsignadoMostrar
AsignadoMostrar=(Fin)

[Pendientes.ListaEnCaptura]
(Inicio)=EmbarqueMov.Empresa
EmbarqueMov.Empresa=EmbarqueMov.Accion
EmbarqueMov.Accion=EmbarqueMov.NombreEnvio
EmbarqueMov.NombreEnvio=EmbarqueMov.Ruta
EmbarqueMov.Ruta=EmbarqueMov.Zona
EmbarqueMov.Zona=EmbarqueMov.Peso
EmbarqueMov.Peso=EmbarqueMov.Volumen
EmbarqueMov.Volumen=EmbarqueMov.Paquetes
EmbarqueMov.Paquetes=ImporteTotal
ImporteTotal=EmbarqueMov.Ubicacion
EmbarqueMov.Ubicacion=(Fin)

[Pendientes.ListaAcciones]
(Inicio)=PendientesAsignar
PendientesAsignar=PendientesSeleccionarTodo
PendientesSeleccionarTodo=PendienteExaminar
PendienteExaminar=CancelarLocal
CancelarLocal=PendienteMostrarCampos
PendienteMostrarCampos=(Fin)

[Pendientes.EmbarqueMov.Ubicacion]
Carpeta=Pendientes
Clave=EmbarqueMov.Ubicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco



[Forma.ListaCarpetas]
(Inicio)=Pendientes
Pendientes=Asignado
Asignado=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Asignar
Asignar=AsignarTodo
AsignarTodo=Localizar
Localizar=(Fin)
