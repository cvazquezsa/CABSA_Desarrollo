[Forma]
Clave=ProcesarVentaN2
Nombre=Notas (por Procesar)
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=502
PosicionInicialArriba=248
PosicionInicialAltura=506
PosicionInicialAncho=915
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionSeccion1=91
PosicionInicialAlturaCliente=504
ExpresionesAlMostrar=Asigna(Info.MovFactura, ConfigMov.VentaFacturaNota)
EsConsultaExclusiva=S

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaProcesar
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
Filtros=S
BusquedaRapidaControles=S
FiltroUsuarios=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroMonedas=S
FiltroListaEstatus=PROCESAR
FiltroEstatusDefault=PROCESAR
FiltroUsuarioDefault=(Todos)
FiltroFechasNormal=S
FiltroMonedasCampo=Venta.Moneda
MenuLocal=S
ListaAcciones=(Lista)
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Alm
FiltroAncho=20
FiltroTodoNombre=Almacenes
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=M�ltiple (por Grupos)
FiltroGrupo1=Venta.Almacen
FiltroValida1=Venta.Almacen
FiltroTodo=S
FiltroTodoFinal=S
FiltroFechasCampo=Venta.FechaEmision
FiltroFechasDefault=Hoy
IconosSeleccionMultiple=S
FiltroFechas=S
BusquedaRapida=S
BusquedaEnLinea=S
BusquedaRespetarFiltros=S
BusquedaInicializar=S
BusquedaRespetarUsuario=S
BusquedaAncho=20
BusquedaRespetarControlesNum=S
FiltroSucursales=S
FiltroFechasNombre=&Fecha
OtroOrden=S
ListaOrden=(Lista)

IconosNombre=VentaProcesar:Venta.Mov+<T> <T>+VentaProcesar:Venta.MovID
FiltroGeneral=Venta.Empresa=<T>{Empresa}<T> AND<BR>Venta.Estatus=<T>PROCESAR<T> <BR>AND Venta.Mov IN ({MovListaSQL(<T>VTAS<T>, VTAS.N, VTAS.NR)})
FiltroSucursalesSinTodas=S
[Lista.Venta.FechaEmision]
Carpeta=Lista
Clave=Venta.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Venta.Cliente]
Carpeta=Lista
Clave=Venta.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Venta.Agente]
Carpeta=Lista
Clave=Venta.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Venta.Impuestos]
Carpeta=Lista
Clave=Venta.Impuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador=1
ColorFondo=Blanco

[Lista.ImporteTotal]
Carpeta=Lista
Clave=ImporteTotal
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
0=112
1=81
Mov=198
2=-2
3=-2
4=93
5=-2
6=100
7=-2

[Acciones.Mostrar Campos]
Nombre=Mostrar Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreDesplegar=&Procesar selecci�n
EnBarraHerramientas=S
TipoAccion=Controles Captura
Activo=S
Visible=S
NombreEnBoton=S
Antes=S
ClaveAccion=Actualizar Forma
EspacioPrevio=S
ConCondicion=S
EjecucionConError=S

EjecucionCondicion=Forma(<T>EspecificarProcesarVentaN2<T>) y ConDatos(Info.MovFactura) y ConDatos(Info.MovDevolucion) y PuedeEditarMov(<T>VTAS<T>, Info.MovFactura)y PuedeEditarMov(<T>VTAS<T>, Info.MovDevolucion)
EjecucionMensaje=<T>Es necesario seleccionar ambos movimientos (Factura y Devoluci�n) y contar con permisos<T>
AntesExpresiones=RegistrarSeleccionID<BR>ProcesarSQL(<T>spProcesarVentaN :nEstacion, :tEmpresa, :tFactura, :fFecha, :tUsuario,:tCtecno, :nEnSilencio, :nOk, :tOkRef, :tDevolucion<T>, EstacionTrabajo, Empresa, Info.MovFactura,  Ahora, Usuario, Nulo, 0, Nulo, Nulo, Info.MovDevolucion)
[Acciones.SeleccionarTodo]
Nombre=SeleccionarTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.MovPropiedades]
Nombre=MovPropiedades
Boton=35
NombreEnBoton=S
NombreDesplegar=<T>&Movimiento<T>
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, VentaProcesar:Venta.ID)

[(Variables).Info.Mov]
Carpeta=(Variables)
Clave=Info.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Lista.Venta.CtaDinero]
Carpeta=Lista
Clave=Venta.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=55
NombreEnBoton=S
NombreDesplegar=Seleccionar &Todo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S
EspacioPrevio=S

[Lista.SubTotal]
Carpeta=Lista
Clave=SubTotal
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Quitar Seleccion]
Nombre=Quitar Seleccion
Boton=0
NombreDesplegar=Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
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





















[Lista.ListaEnCaptura]
(Inicio)=Venta.FechaEmision
Venta.FechaEmision=Venta.Cliente
Venta.Cliente=Venta.Agente
Venta.Agente=SubTotal
SubTotal=Venta.Impuestos
Venta.Impuestos=ImporteTotal
ImporteTotal=Venta.CtaDinero
Venta.CtaDinero=(Fin)

[Lista.ListaOrden]
(Inicio)=Venta.FechaEmision	(Acendente)
Venta.FechaEmision	(Acendente)=Venta.ID	(Acendente)
Venta.ID	(Acendente)=(Fin)

[Lista.ListaAcciones]
(Inicio)=SeleccionarTodo
SeleccionarTodo=Quitar Seleccion
Quitar Seleccion=(Fin)















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Afectar
Afectar=Seleccionar Todo
Seleccionar Todo=MovPropiedades
MovPropiedades=Mostrar Campos
Mostrar Campos=(Fin)
