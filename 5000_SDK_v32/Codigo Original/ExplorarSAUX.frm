[Forma]
Clave=ExplorarSAUX
Nombre=<T>Explorando - Servicios Auxiliares<T>
Icono=47
Modulos=SAUX
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=218
PosicionInicialArriba=182
PosicionInicialAltura=448
PosicionInicialAncho=1163
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=467
MovModulo=SAUX
EsMovimiento=S
TituloAuto=S
MovEspecificos=Todos

PosicionSec1=375
PosicionSec2=407
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Movimientos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SAUXExplorar
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroListas=S
FiltroListasRama=CXP
FiltroListasAplicaEn=Compra.Proveedor
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ProvCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ProvFam
FiltroTodo=S
FiltroTodoFinal=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=CONCLUIDO
FiltroFechasCampo=SAUX.FechaEmision
FiltroFechasDefault=Este Mes
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroMovsTodos=S
FiltroMovDefault=(Todos)
PermiteLocalizar=S
FiltroSucursales=S
FiltroProyectos=S
FiltroUENs=S
FiltroUENsCampo=SAUX.UEN
FiltroSituacionTodo=S
FiltroMovs=S

AnchoTotalizador1=450
TieneTotalizador2=S



ListaEnCaptura=(Lista)
FiltroEstatus=S
IconosConSenales=S
IconosNombre=SAUXExplorar:SAUX.Mov+<T> <T>+SAUXExplorar:SAUX.MovID
FiltroGeneral=SAUX.Empresa=<T>{Empresa}<T>
[Lista.Columnas]
0=143
1=81

2=-2
3=-2
4=85
5=178
6=67
7=106
8=95
9=88
10=116
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

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a E&xcel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S




[Acciones.Mostrar Campos]
Nombre=Mostrar Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.ProvInfo]
Nombre=ProvInfo
Boton=34
NombreEnBoton=S
NombreDesplegar=&Proveedor
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ProvInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S

EjecucionCondicion=ConDatos(SAUXExplorar:SAUX.Contacto) Y (SAUXExplorar:SAUX.TipoContacto=<T>Proveedor<T>)
AntesExpresiones=Asigna(Info.Proveedor, SAUXExplorar:SAUX.Contacto)
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
ConCondicion=S
Antes=S
Visible=S

EjecucionCondicion=ConDatos(SAUXExplorar:SAUX.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>SAUX<T>)<BR>Asigna(Info.ID, SAUXExplorar:SAUX.ID)
[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Presentacion preliminar]
Nombre=Presentacion preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S








[Lista.SAUX.FechaEmision]
Carpeta=Lista
Clave=SAUX.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.SAUX.TipoContacto]
Carpeta=Lista
Clave=SAUX.TipoContacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.SAUX.Contacto]
Carpeta=Lista
Clave=SAUX.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.SAUX.OrigenTipo]
Carpeta=Lista
Clave=SAUX.OrigenTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco






[Lista.MovimientoOrigen]
Carpeta=Lista
Clave=MovimientoOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.EstatusOrigen]
Carpeta=Lista
Clave=EstatusOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.FechaOrigen]
Carpeta=Lista
Clave=FechaOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco







[Lista.NombreContacto]
Carpeta=Lista
Clave=NombreContacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco












[Lista.ImporteOrigen]
Carpeta=Lista
Clave=ImporteOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


















Totalizador=1
Totalizador2=N
[Lista.SAUX.FechaEntrega]
Carpeta=Lista
Clave=SAUX.FechaEntrega
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
















[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=
Totalizadores2=
Totalizadores3=
Totalizadores=S
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S












[Lista.ListaEnCaptura]
(Inicio)=SAUX.FechaEmision
SAUX.FechaEmision=SAUX.FechaEntrega
SAUX.FechaEntrega=SAUX.TipoContacto
SAUX.TipoContacto=SAUX.Contacto
SAUX.Contacto=NombreContacto
NombreContacto=SAUX.OrigenTipo
SAUX.OrigenTipo=MovimientoOrigen
MovimientoOrigen=EstatusOrigen
EstatusOrigen=FechaOrigen
FechaOrigen=ImporteOrigen
ImporteOrigen=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)


























[Acciones.CteInfo]
Nombre=CteInfo
Boton=34
NombreEnBoton=S
NombreDesplegar=&Cliente
EnBarraHerramientas=S
Activo=S
Visible=S



TipoAccion=Formas
ClaveAccion=CteInfo




ConCondicion=S
Antes=S












EjecucionCondicion=ConDatos(SAUXExplorar:SAUX.Contacto) Y (SAUXExplorar:SAUX.TipoContacto=<T>Cliente<T>)
AntesExpresiones=Asigna(Info.Cliente, SAUXExplorar:SAUX.Contacto)




[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=ProvInfo
ProvInfo=CteInfo
CteInfo=MovPropiedades
MovPropiedades=Mostrar Campos
Mostrar Campos=(Fin)
