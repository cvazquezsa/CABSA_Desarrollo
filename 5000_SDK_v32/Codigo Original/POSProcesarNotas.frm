
[Forma]
Clave=POSProcesarNotas
Nombre=Facturar Notas Lote
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=198
PosicionInicialArriba=57
PosicionInicialAltura=506
PosicionInicialAncho=970
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionSeccion1=91
PosicionInicialAlturaCliente=575
ExpresionesAlMostrar=Asigna(Info.MovFactura, ConfigMov.VentaFacturaNota)
EsConsultaExclusiva=S

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSL
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
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=(Todos)
FiltroUsuarioDefault=(Todos)
FiltroFechasNormal=S
FiltroMonedasCampo=POSL.Moneda
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
FiltroTipo=Múltiple (por Grupos)
FiltroGrupo1=POSL.Almacen
FiltroValida1=POSL.Almacen
FiltroTodo=S
FiltroTodoFinal=S
FiltroFechasCampo=POSL.FechaEmision
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
ListaOrden=POSL.FechaEmision<TAB>(Acendente)






PestanaNombre=Notas
IconosNombre=POSL:POSL.Mov+<T> <T>+POSL:POSL.MovID
FiltroGeneral=POSL.Empresa=<T>{Empresa}<T> AND<BR>POSL.Estatus IN(<T>CONCLUIDO<T>,<T>TRASPASADO<T>) AND<BR>POSL.Facturado = 0 AND<BR>MovTipo.Modulo = <T>POS<T> AND<BR>POSL.Importe>=0.0  AND<BR>POSL.Mov IN ({MovListaSQL(<T>POS<T>,POS.N)})
[Lista.Columnas]
0=146
1=81

2=39
3=76
4=99
5=82
6=-2

Cliente=117
Nombre=293
RFC=107
7=-2
[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreDesplegar=&Procesar selección
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
NombreEnBoton=S
EspacioPrevio=S

GuardarAntes=S
Expresion=RegistrarSeleccion(<T>POSProcesarNotas<T>) <BR>FormaModal(<T>POSFacturarNotasTemp2<T>)<BR>ActualizarForma
[Acciones.SeleccionarTodo]
Nombre=SeleccionarTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S


[(Variables).Info.Mov]
Carpeta=(Variables)
Clave=Info.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20


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


[Lista.ListaOrden]
(Inicio)=Venta.FechaEmision	(Acendente)
Venta.FechaEmision	(Acendente)=Venta.ID	(Acendente)
Venta.ID	(Acendente)=(Fin)





[Lista.POSL.FechaEmision]
Carpeta=Lista
Clave=POSL.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.POSL.Cliente]
Carpeta=Lista
Clave=POSL.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.POSL.Agente]
Carpeta=Lista
Clave=POSL.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[Lista.POSL.Impuestos]
Carpeta=Lista
Clave=POSL.Impuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Lista.POSL.Caja]
Carpeta=Lista
Clave=POSL.Caja
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

















































[Lista.SubTotal]
Carpeta=Lista
Clave=SubTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Lista.ImporteTotal]
Carpeta=Lista
Clave=ImporteTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1





[Lista.ListaEnCaptura]
(Inicio)=POSL.FechaEmision
POSL.FechaEmision=POSL.Caja
POSL.Caja=POSL.Cliente
POSL.Cliente=POSL.Agente
POSL.Agente=SubTotal
SubTotal=POSL.Impuestos
POSL.Impuestos=ImporteTotal
ImporteTotal=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=CONCLUIDO
CONCLUIDO=TRASPASADO
TRASPASADO=(Fin)

[Lista.ListaAcciones]
(Inicio)=SeleccionarTodo
SeleccionarTodo=Quitar Seleccion
Quitar Seleccion=(Fin)

















































[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Afectar
Afectar=Seleccionar Todo
Seleccionar Todo=(Fin)
