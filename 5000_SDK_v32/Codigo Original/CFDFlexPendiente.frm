
[Forma]
Clave=CFDFlexPendiente
Icono=0
CarpetaPrincipal=CFDFlexPendiente
BarraHerramientas=S
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Monitor CFD Flexible
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=CFDFlexPendiente
PosicionInicialIzquierda=203
PosicionInicialArriba=65
PosicionInicialAlturaCliente=642
PosicionInicialAncho=996
ListaAcciones=(Lista)
[CFDFlexPendiente]
Estilo=Iconos
Clave=CFDFlexPendiente
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDFlexPendiente
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
FiltroEstatusDefault=PROCESANDO
FiltroFechasCampo=CFDFlexPendiente.FechaEmision
FiltroFechasDefault=Hoy
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S
PermiteLocalizar=S


FiltroPredefinido1=
FiltroPredefinido2=
FiltroPredefinido3=
FiltroAutoCampo=CFDFlexPendiente.Modulo
FiltroAutoValidar=CFDFlexPendiente.Modulo
FiltroAutoOrden=CFDFlexPendiente.Modulo
BusquedaRapida=S
BusquedaRespetarFiltros=S
BusquedaEnLinea=S
IconosSubTitulo=<T>Movimiento<T>
FiltroGrupo1=CFDFlexPendiente.Modulo
FiltroValida1=CFDFlexPendiente.Modulo
FiltroTodo=S
FiltroTodoFinal=S
IconosSeleccionMultiple=S
MenuLocal=S
ListaAcciones=(Lista)
PestanaOtroNombre=S
PestanaNombre=Movimientos Pendientes
IconosNombre=CFDFlexPendiente:CFDFlexPendiente.Mov
FiltroGeneral=CFDFlexPendiente.Empresa = <T>{Empresa}<T>
[CFDFlexPendiente.CFDFlexPendiente.MovID]
Carpeta=CFDFlexPendiente
Clave=CFDFlexPendiente.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CFDFlexPendiente.CFDFlexPendiente.Cliente_Proveedor]
Carpeta=CFDFlexPendiente
Clave=CFDFlexPendiente.Cliente_Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[CFDFlexPendiente.CFDFlexPendiente.Importe]
Carpeta=CFDFlexPendiente
Clave=CFDFlexPendiente.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[CFDFlexPendiente.Columnas]
0=87
1=90
2=100
3=252























4=82
5=82
6=121
[Acciones.Expresion]
Nombre=Expresion
Boton=7
NombreDesplegar=&Generar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
NombreEnBoton=S

EspacioPrevio=S
Expresion=Si<BR>  CuantosSeleccionID(<T>CFDFlexPendiente<T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>CFDFlexPendiente<T>)<BR><BR>ProcesarSQL(<T> spGenerarCFDFlexLote :nEstacion, :tEmpresa<T>,EstacionTrabajo,Empresa)  <BR><BR>Fin<BR>ActualizarForma
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














[CFDFlexPendiente.CFDFlexPendiente.Impuestos]
Carpeta=CFDFlexPendiente
Clave=CFDFlexPendiente.Impuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[CFDFlexPendiente.ImporteTotal]
Carpeta=CFDFlexPendiente
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








[CFDFlexPendiente.ReceptorNombre]
Carpeta=CFDFlexPendiente
Clave=ReceptorNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco




























[CFDFlexPendiente.ListaEnCaptura]
(Inicio)=CFDFlexPendiente.MovID
CFDFlexPendiente.MovID=CFDFlexPendiente.Cliente_Proveedor
CFDFlexPendiente.Cliente_Proveedor=ReceptorNombre
ReceptorNombre=CFDFlexPendiente.Importe
CFDFlexPendiente.Importe=CFDFlexPendiente.Impuestos
CFDFlexPendiente.Impuestos=ImporteTotal
ImporteTotal=(Fin)

[CFDFlexPendiente.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ERROR
ERROR=PROCESANDO
PROCESANDO=(Fin)

[CFDFlexPendiente.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=Quitar Seleccion
Quitar Seleccion=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Expresion
Expresion=(Fin)
