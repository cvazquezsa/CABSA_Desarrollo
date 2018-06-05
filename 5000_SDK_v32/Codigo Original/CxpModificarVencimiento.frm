[Forma]
Clave=CxpModificarVencimiento
Nombre=<T>Modificar Vencimiento - Cuentas por Pagar<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=538
PosicionInicialArriba=347
PosicionInicialAltura=508
PosicionInicialAncho=843
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsMovimiento=S
TituloAuto=S
MovModulo=Cxp
MovEspecificos=Todos
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=479
Comentarios=Info.Proveedor

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Cxp
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
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=Mon
FiltroNullNombre=(sin clasificar)
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroAplicaEn=Cxp.Moneda
FiltroRespetar=S
FiltroTipo=General
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSituacionTodo=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
FiltroFechasCampo=Cxp.Vencimiento
FiltroFechasDefault=(Todo)
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Movimientos
FiltroMovs=S
FiltroMovsTodos=S
FiltroMovDefault=(Todos)
FiltroMonedasCampo=Cxp.Moneda
FiltroSucursales=S
FiltroMonedas=S
FiltroProyectos=S
FiltroUENs=S
FiltroUENsCampo=Cxp.UEN
IconosSeleccionMultiple=S
FiltroFechas=S
FiltroFechasVencimiento=S
FiltroFechasNombre=&Vencimiento
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=Cxp:Cxp.Mov+<T> <T>+Cxp:Cxp.MovID
FiltroGeneral=Cxp.Empresa=<T>{Empresa}<T> AND Cxp.Estatus=<T>PENDIENTE<T> AND Cxp.Proveedor=<T>{Info.Proveedor}<T>

[Lista.Cxp.FechaEmision]
Carpeta=Lista
Clave=Cxp.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cxp.Referencia]
Carpeta=Lista
Clave=Cxp.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cxp.Concepto]
Carpeta=Lista
Clave=Cxp.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=127
1=91

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

[Lista.Cxp.Vencimiento]
Carpeta=Lista
Clave=Cxp.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
NombreDesplegar=Presentación preliminar
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

[Acciones.Campos]
Nombre=Campos
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
Boton=35
NombreDesplegar=Propiedades
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Visible=S
ConCondicion=S
Antes=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(Cxp:Cxp.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>Cxp<T>)<BR>Asigna(Info.ID, Cxp:Cxp.ID)

[Acciones.ProvInfo]
Nombre=ProvInfo
Boton=34
NombreDesplegar=Información
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ProvInfo
ConCondicion=S
Antes=S
Visible=S
Activo=S
EjecucionCondicion=ConDatos(Cxp:Cxp.Proveedor)
AntesExpresiones=Asigna(Info.Proveedor, Cxp:Cxp.Proveedor)

[Lista.SaldoF]
Carpeta=Lista
Clave=SaldoF
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cxp.Importe]
Carpeta=Lista
Clave=Cxp.Importe
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cxp.Impuestos]
Carpeta=Lista
Clave=Cxp.Impuestos
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ImporteTotal]
Carpeta=Lista
Clave=ImporteTotal
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Modificar]
Nombre=Modificar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Modificar Vencimiento
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Si<BR> Forma(<T>EspecificarFecha<T>)<BR>Entonces<BR>  Si<BR>    Confirmacion(<T>¿ Esta Seguro que desea Modificar el Vencimiento <T>+<BR>                 <T>de los Movimientos Seleccionados al <T> + <BR>                 FechaEnTexto(Info.Fecha, <T>dd/mmm/aaaa<T>)+<T> ?<T>, BotonSi, BotonNo)=BotonSi<BR>  Entonces<BR>    RegistrarSeleccionID(<T>Lista<T>) <BR>    EjecutarSQL(<T>spCxModificarVencimiento :tModulo, :nEstacion, :fFecha<T>, <T>Cxp<T>, EstacionTrabajo, Info.Fecha) <BR>    Forma.ActualizarVista <BR>  Fin<BR>Fin

[Acciones.Todo]
Nombre=Todo
Boton=55
NombreDesplegar=Seleccionar &Todo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.LocalQuitar]
Nombre=LocalQuitar
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.LocalTodo]
Nombre=LocalTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Todo
Todo=Modificar
Modificar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Propiedades
Propiedades=ProvInfo
ProvInfo=Campos
Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Cxp.FechaEmision
Cxp.FechaEmision=Cxp.Vencimiento
Cxp.Vencimiento=Cxp.Referencia
Cxp.Referencia=Cxp.Concepto
Cxp.Concepto=Cxp.Importe
Cxp.Importe=Cxp.Impuestos
Cxp.Impuestos=ImporteTotal
ImporteTotal=SaldoF
SaldoF=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=SINAFECTAR
SINAFECTAR=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=(Fin)
