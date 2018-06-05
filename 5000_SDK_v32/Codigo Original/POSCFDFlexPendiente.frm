
[Forma]
Clave=POSCFDFlexPendiente
Icono=0
CarpetaPrincipal=POSCFDFlexPendiente
BarraHerramientas=S
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Monitor CFD Flexible POS
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=POSCFDFlexPendiente
PosicionInicialIzquierda=1742
PosicionInicialArriba=172
PosicionInicialAlturaCliente=642
PosicionInicialAncho=996
ListaAcciones=(Lista)
[POSCFDFlexPendiente]
Estilo=Iconos
Clave=POSCFDFlexPendiente
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCFDFlexPendiente
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroEstatus=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSucursales=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=(Todos)
FiltroFechasCampo=POSCFDFlexPendiente.FechaEmision
FiltroFechasDefault=Hoy
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S
PermiteLocalizar=S


FiltroPredefinido1=
FiltroPredefinido2=
FiltroPredefinido3=
FiltroAutoCampo=POSCFDFlexPendiente.Modulo
FiltroAutoValidar=POSCFDFlexPendiente.Modulo
FiltroAutoOrden=POSCFDFlexPendiente.Modulo
BusquedaRapida=S
BusquedaRespetarFiltros=S
BusquedaEnLinea=S
IconosSubTitulo=<T>Movimiento<T>
FiltroGrupo1=POSCFDFlexPendiente.Modulo
FiltroValida1=POSCFDFlexPendiente.Modulo
FiltroTodo=S
FiltroTodoFinal=S
IconosSeleccionMultiple=S
MenuLocal=S
ListaAcciones=(Lista)
PestanaOtroNombre=S
PestanaNombre=Movimientos Pendientes
IconosNombre=POSCFDFlexPendiente:POSCFDFlexPendiente.Mov
FiltroGeneral=POSCFDFlexPendiente.Empresa = <T>{Empresa}<T>
[POSCFDFlexPendiente.POSCFDFlexPendiente.MovID]
Carpeta=POSCFDFlexPendiente
Clave=POSCFDFlexPendiente.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSCFDFlexPendiente.POSCFDFlexPendiente.Cliente_Proveedor]
Carpeta=POSCFDFlexPendiente
Clave=POSCFDFlexPendiente.Cliente_Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[POSCFDFlexPendiente.POSCFDFlexPendiente.Importe]
Carpeta=POSCFDFlexPendiente
Clave=POSCFDFlexPendiente.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSCFDFlexPendiente.Columnas]
0=87
1=90
2=100
3=252























4=82
5=82
6=121

[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S














[POSCFDFlexPendiente.POSCFDFlexPendiente.Impuestos]
Carpeta=POSCFDFlexPendiente
Clave=POSCFDFlexPendiente.Impuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[POSCFDFlexPendiente.ImporteTotal]
Carpeta=POSCFDFlexPendiente
Clave=ImporteTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
































[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=0
NombreDesplegar=Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Quitar Seleccion]
Nombre=Quitar Seleccion
Boton=0
NombreDesplegar=Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S








[POSCFDFlexPendiente.ReceptorNombre]
Carpeta=POSCFDFlexPendiente
Clave=ReceptorNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
































[POSCFDFlexPendiente.ListaEnCaptura]
(Inicio)=POSCFDFlexPendiente.MovID
POSCFDFlexPendiente.MovID=POSCFDFlexPendiente.Cliente_Proveedor
POSCFDFlexPendiente.Cliente_Proveedor=ReceptorNombre
ReceptorNombre=POSCFDFlexPendiente.Importe
POSCFDFlexPendiente.Importe=POSCFDFlexPendiente.Impuestos
POSCFDFlexPendiente.Impuestos=ImporteTotal
ImporteTotal=(Fin)

[POSCFDFlexPendiente.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ERROR
ERROR=PROCESANDO
PROCESANDO=(Fin)

[POSCFDFlexPendiente.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=Quitar Seleccion
Quitar Seleccion=(Fin)








[Acciones.Cancelar]
Nombre=Cancelar
Boton=33
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S





NombreEnBoton=S
EspacioPrevio=S









Expresion=Si<BR>  CuantosSeleccionID(<T>POSCFDFlexPendiente<T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>POSCFDFlexPendiente<T>)<BR><BR>  Dialogo(<T>POSCancelarCFDFlex<T>)<BR><BR>Fin<BR>ActualizarForma
[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S

























Expresion=Si<BR>  CuantosSeleccionID(<T>POSCFDFlexPendiente<T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>POSCFDFlexPendiente<T>)<BR><BR>  ProcesarSQL(<T> spPOSGenerarCFDFlexLote :nEstacion, :tEmpresa<T>,EstacionTrabajo,Empresa)<BR><BR>Fin<BR>ActualizarForma




[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Generar
Generar=Cancelar
Cancelar=(Fin)
