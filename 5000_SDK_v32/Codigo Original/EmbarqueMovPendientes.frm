[Forma]
Clave=EmbarqueMovPendientes
Nombre=Movimientos Pendientes por Embarcar
Icono=6
Modulos=(Todos)
ListaCarpetas=Pendientes
CarpetaPrincipal=Pendientes
PosicionInicialIzquierda=0
PosicionInicialArriba=203
PosicionInicialAltura=449
PosicionInicialAncho=869
PosicionColumna1=61
PosicionSeccion1=57
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
EsConsultaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=421

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
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Pendientes
MenuLocal=S
ListaAcciones=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Ruta
FiltroAncho=20
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
OtroOrden=S
ListaOrden=EmbarqueMov.ID<TAB>(Acendente)
PermiteLocalizar=S
FiltroGrupo1=EmbarqueMov.Zona
FiltroValida1=EmbarqueMov.Zona
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroEmpresas=S
FiltroSucursales=S
FiltroFechasCampo=EmbarqueMov.FechaEmision
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroGrupo2=EmbarqueMov.Ruta
FiltroValida2=EmbarqueMov.Ruta
FiltroIgnorarEmpresas=S

TieneTotalizador2=S
AnchoTotalizador1=500
IconosNombre=EmbarqueMov:EmbarqueMov.Mov+ <T> <T> +EmbarqueMov:EmbarqueMov.MovID
FiltroGeneral=EmbarqueMov.MovEstatus NOT IN (<T>SINAFECTAR<T>, <T>CANCELADO<T>) AND EmbarqueMov.Accion IS NOT NULL AND<BR>EmbarqueMov.AsignadoID = {Si(Info.AntecedenteID = 0, <T>NULL<T>, Info.AntecedenteID)}
[Pendientes.EmbarqueMov.Zona]
Carpeta=Pendientes
Clave=EmbarqueMov.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Pendientes.Columnas]
0=95
1=66

2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
9=-2
[Asignado.Columnas]
0=109
1=41

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
Tamano=50
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

[Asignado.EmbarqueMov.ZonaTipo]
Carpeta=Asignado
Clave=EmbarqueMov.ZonaTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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
NombreDesplegar=Presentacion preliminar
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

[Acciones.LocalCampos]
Nombre=LocalCampos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
UsaTeclaRapida=S
TeclaRapida=F11
NombreDesplegar=&Propiedades
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Visible=S
Antes=S
ConCondicion=S
ActivoCondicion=ConDatos(EmbarqueMov:EmbarqueMov.ModuloID)
EjecucionCondicion=ConDatos(EmbarqueMov:EmbarqueMov.ModuloID)
AntesExpresiones=Asigna(Info.Modulo, EmbarqueMov:EmbarqueMov.Modulo)<BR>Asigna(Info.ID, EmbarqueMov:EmbarqueMov.ModuloID)

[Acciones.CancelarLocal.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=ProcesarSQL(<T>spEmbarqueManual :tEmpresa, :tModulo, :nID, :tMov, :tMovID, :tEstatus, 1<T>, Empresa, Info.Modulo, Info.ID, Info.Mov, Info.MovID, Info.Estatus)

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
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
ListaAccionesMultiples=Expresion<BR>Actualizar Vista
ConCondicion=S
Antes=S
Visible=S
ActivoCondicion=Usuario.CancelarEmbarquesExplorador y ConDatos(EmbarqueMov:EmbarqueMov.ModuloID)
EjecucionCondicion=ConDatos(EmbarqueMov:EmbarqueMov.ModuloID)
AntesExpresiones=Asigna(Info.Descripcion, <T>Cancelar Embarque<T>)<BR>Asigna(Info.Modulo, EmbarqueMov:EmbarqueMov.Modulo)<BR>Asigna(Info.ID, EmbarqueMov:EmbarqueMov.ModuloID)<BR>Asigna(Info.Mov, EmbarqueMov:EmbarqueMov.Mov)<BR>Asigna(Info.MovID, EmbarqueMov:EmbarqueMov.MovID)<BR>Asigna(Info.Estatus, EmbarqueMov:EmbarqueMov.MovEstatus)

[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreDesplegar=Cancelar Embarque
Multiple=S
EnBarraHerramientas=S
EspacioPrevio=S
ConCondicion=S
Visible=S
ConfirmarAntes=S
DialogoMensaje=MovEmbarcarConfirmar
ListaAccionesMultiples=Expresion<BR>Actualizar Vista
Antes=S
ActivoCondicion=Usuario.CancelarEmbarquesExplorador
EjecucionCondicion=ConDatos(EmbarqueMov:EmbarqueMov.ModuloID)
AntesExpresiones=Asigna(Info.Descripcion, <T>Cancelar Embarque<T>)<BR>Asigna(Info.Modulo, EmbarqueMov:EmbarqueMov.Modulo)<BR>Asigna(Info.ID, EmbarqueMov:EmbarqueMov.ModuloID)<BR>Asigna(Info.Mov, EmbarqueMov:EmbarqueMov.Mov)<BR>Asigna(Info.MovID, EmbarqueMov:EmbarqueMov.MovID)<BR>Asigna(Info.Estatus, EmbarqueMov:EmbarqueMov.MovEstatus)

[Acciones.Cancelar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=ProcesarSQL(<T>spEmbarqueManual :tEmpresa, :tModulo, :nID, :tMov, :tMovID, :tEstatus, 1<T>, Empresa, Info.Modulo, Info.ID, Info.Mov, Info.MovID, Info.Estatus)

[Acciones.Cancelar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Pendientes.Dias]
Carpeta=Pendientes
Clave=Dias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Totalizador=2

[Pendientes.EmbarqueMov.Cliente]
Carpeta=Pendientes
Clave=EmbarqueMov.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Pendientes.EmbarqueMov.ClienteEnviarA]
Carpeta=Pendientes
Clave=EmbarqueMov.ClienteEnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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

[Acciones.Propiedades2]
Nombre=Propiedades2
Boton=35
NombreDesplegar=Propiedades
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(EmbarqueMov:EmbarqueMov.ModuloID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, EmbarqueMov:EmbarqueMov.Modulo)<BR>Asigna(Info.ID, EmbarqueMov:EmbarqueMov.ModuloID)

[Pendientes.Throughput]
Carpeta=Pendientes
Clave=Throughput
Editar=S
Totalizador=2
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreDesplegar=Detalle
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EmbarqueVentaPendiente
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=EmbarqueMov:EmbarqueMov.Modulo=<T>VTAS<T>
EjecucionMensaje=<T>Esta Opción Funciona con Movimientos de Ventas<T>
EjecucionConError=S
AntesExpresiones=Asigna(Info.ID, EmbarqueMov:EmbarqueMov.ModuloID)<BR>Asigna(Info.Mov, EmbarqueMov:EmbarqueMov.Mov)<BR>Asigna(Info.MovID, EmbarqueMov:EmbarqueMov.MovID)


[Pendientes.ImporteTotalMN]
Carpeta=Pendientes
Clave=ImporteTotalMN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





















Totalizador=1
Totalizador2=S




[Pendientes.ListaEnCaptura]
(Inicio)=EmbarqueMov.Zona
EmbarqueMov.Zona=EmbarqueMov.Ruta
EmbarqueMov.Ruta=EmbarqueMov.Cliente
EmbarqueMov.Cliente=EmbarqueMov.ClienteEnviarA
EmbarqueMov.ClienteEnviarA=EmbarqueMov.NombreEnvio
EmbarqueMov.NombreEnvio=ImporteTotal
ImporteTotal=Dias
Dias=Throughput
Throughput=ImporteTotalMN
ImporteTotalMN=(Fin)

[Pendientes.ListaAcciones]
(Inicio)=Propiedades
Propiedades=CancelarLocal
CancelarLocal=PendienteMostrarCampos
PendienteMostrarCampos=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Localizar
Localizar=Propiedades2
Propiedades2=Detalle
Detalle=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Cancelar
Cancelar=LocalCampos
LocalCampos=(Fin)
