[Forma]
Clave=CxpPendienteLista
Nombre=<T>Pendientes por Pagar<T>
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=538
PosicionInicialArriba=374
PosicionInicialAltura=370
PosicionInicialAncho=843
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
Comentarios=Lista(Info.Proveedor,Info.Moneda, Info.Mov)
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=415

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxpPendiente
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
OtroOrden=S
PestanaOtroNombre=S
FiltroPredefinido=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
PermiteLocalizar=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Consecutivo<T>
ElementosPorPagina=200
ListaOrden=CxpPendiente.Vencimiento<TAB>(Acendente)
PestanaNombre=Movimientos
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=CxpPendiente.FechaEmision
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroSucursales=S
BusquedaRapida=S
BusquedaRespetarFiltros=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
MenuLocal=S
IconosNombre=CxpPendiente:CxpPendiente.MovID
FiltroGeneral=CxpPendiente.Mov=<T>{Info.Mov}<T> AND<BR>CxpPendiente.Proveedor=<T>{Info.Proveedor}<T> AND<BR>CxpPendiente.Moneda=<T>{Info.Moneda}<T> AND<BR>CxpPendiente.Empresa=<T>{Empresa}<T>
ListaAcciones=(Lista)

[Lista.Columnas]
Mov=114
MovID=64
FechaEmision=83
Vencimiento=76
Saldo=93
Importe=82
0=71
1=99
Referencia=107

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreDesplegar=&Seleccionar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Visible=S
Activo=S
NombreEnBoton=S
EnBarraHerramientas=S

[Lista.CxpPendiente.Referencia]
Carpeta=Lista
Clave=CxpPendiente.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CxpPendiente.FechaEmision]
Carpeta=Lista
Clave=CxpPendiente.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CxpPendiente.Saldo]
Carpeta=Lista
Clave=CxpPendiente.Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.CxpPendiente.ImporteTotal]
Carpeta=Lista
Clave=CxpPendiente.ImporteTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.CxpPendiente.Vencimiento]
Carpeta=Lista
Clave=CxpPendiente.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=Propiedades
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(CxpPendiente:CxpPendiente.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CXP<T>)<BR>Asigna(Info.ID, CxpPendiente:CxpPendiente.ID)

[Lista.CxpPendiente.Moneda]
Carpeta=Lista
Clave=CxpPendiente.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Quitar Seleccion]
Nombre=Quitar Seleccion
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Lista.CxpPendiente.Concepto]
Carpeta=Lista
Clave=CxpPendiente.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.LocalTodo]
Nombre=LocalTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.LocaQuitar]
Nombre=LocaQuitar
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Propiedades
Propiedades=Campos
Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CxpPendiente.Referencia
CxpPendiente.Referencia=CxpPendiente.Concepto
CxpPendiente.Concepto=CxpPendiente.FechaEmision
CxpPendiente.FechaEmision=CxpPendiente.Vencimiento
CxpPendiente.Vencimiento=CxpPendiente.ImporteTotal
CxpPendiente.ImporteTotal=CxpPendiente.Saldo
CxpPendiente.Saldo=CxpPendiente.Moneda
CxpPendiente.Moneda=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocaQuitar
LocaQuitar=(Fin)
