[Forma]
Clave=ExplorarCompra
Nombre=<T>Explorando - Compras<T>
Icono=47
Modulos=COMS
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=93
PosicionInicialArriba=269
PosicionInicialAltura=448
PosicionInicialAncho=1093
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=421
MovModulo=COMS
EsMovimiento=S
TituloAuto=S
MovEspecificos=Todos

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
Vista=CompraExplorar
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
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
FiltroFechasCampo=Compra.FechaEmision
FiltroFechasDefault=Este Mes
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroMovsTodos=S
FiltroMovDefault=(Todos)
FiltroMonedas=S
FiltroMonedasCampo=Compra.Moneda
PermiteLocalizar=S
FiltroSucursales=S
FiltroProyectos=S
FiltroUENs=S
FiltroUENsCampo=Compra.UEN
FiltroSituacionTodo=S
FiltroEstatus=S
FiltroSituacion=S
FiltroMovs=S

AnchoTotalizador1=450
TieneTotalizador2=S
OtroOrden=S
ListaOrden=Compra.ID<TAB>(Acendente)
Paginacion=S
PaginacionTamano=1000
IconosNombre=CompraExplorar:Compra.Mov+<T> <T>+CompraExplorar:Compra.MovID
FiltroGeneral=Compra.Empresa=<T>{Empresa}<T> AND<BR>Compra.Estatus IN (<T>CONCLUIDO<T>, <T>CANCELADO<T>, <T>PENDIENTE<T>, <T>SINAFECTAR<T>) AND<BR>Compra.Mov IN ({MovListaSQL(<T>COMS<T>, COMS.F, COMS.FL, COMS.EG, COMS.EI, COMS.D, COMS.B)})
[Lista.Compra.FechaEmision]
Carpeta=Lista
Clave=Compra.FechaEmision
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Compra.Proveedor]
Carpeta=Lista
Clave=Compra.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Compra.Almacen]
Carpeta=Lista
Clave=Compra.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Columnas]
0=143
1=81

2=-2
3=-2
4=-2
5=-2
6=120
7=163
8=160
9=-2
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

Antes=S
AntesExpresiones=Asigna(Info.Filtro,<T> where <T> & Carpeta.FiltroActual( <T>Lista<T> ))<BR>Asigna(Info.Valor,<T> <T> & Carpeta.FiltroActual( <T>Lista<T> ))
[Lista.SubTotalNeto]
Carpeta=Lista
Clave=SubTotalNeto
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ImpuestosNetos]
Carpeta=Lista
Clave=ImpuestosNetos
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ImporteTotalNeto]
Carpeta=Lista
Clave=ImporteTotalNeto
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

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
EjecucionCondicion=ConDatos(CompraExplorar:Compra.Proveedor)
AntesExpresiones=Asigna(Info.Proveedor, CompraExplorar:Compra.Proveedor)

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
EjecucionCondicion=ConDatos(CompraExplorar:Compra.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, CompraExplorar:Compra.ID)

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Impresora
ClaveAccion=ExplorarCompraTotales
Activo=S
Visible=S

Antes=S
AntesExpresiones=Asigna(Info.Filtro,<T> where <T> & Carpeta.FiltroActual( <T>Lista<T> ))<BR>Asigna(Info.Valor,<T> <T> & Carpeta.FiltroActual( <T>Lista<T> ))
[Acciones.Presentacion preliminar]
Nombre=Presentacion preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=ExplorarCompraTotales
Activo=S
Visible=S



Antes=S
AntesExpresiones=Asigna(Info.Filtro,<T> where <T> & Carpeta.FiltroActual( <T>Lista<T> ))<BR>Asigna(Info.Valor,<T> <T> & Carpeta.FiltroActual( <T>Lista<T> ))
[Lista.SubTotalNetoMN]
Carpeta=Lista
Clave=SubTotalNetoMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco

[Lista.ImpuestosNetosMN]
Carpeta=Lista
Clave=ImpuestosNetosMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco

[Lista.ImporteTotalNetoMN]
Carpeta=Lista
Clave=ImporteTotalNetoMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco











[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador Paginacion
Activo=S
Visible=S




[Acciones.Totales]
Nombre=Totales
Boton=61
NombreEnBoton=S
NombreDesplegar=Totales
EnBarraHerramientas=S
TipoAccion=Formas
Activo=S
Visible=S





Antes=S










ClaveAccion=ExplorarCompraTotales
































AntesExpresiones=Asigna(Info.Filtro,<T> where <T> & Carpeta.FiltroActual( <T>Lista<T> ))<BR>Asigna(Info.Valor,<T> <T> & Carpeta.FiltroActual( <T>Lista<T> ))


























[Lista.ListaEnCaptura]
(Inicio)=Compra.FechaEmision
Compra.FechaEmision=Compra.Proveedor
Compra.Proveedor=Compra.Almacen
Compra.Almacen=SubTotalNeto
SubTotalNeto=ImpuestosNetos
ImpuestosNetos=ImporteTotalNeto
ImporteTotalNeto=SubTotalNetoMN
SubTotalNetoMN=ImpuestosNetosMN
ImpuestosNetosMN=ImporteTotalNetoMN
ImporteTotalNetoMN=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=(por Autorizar)
(por Autorizar)=SINAFECTAR
SINAFECTAR=CONFIRMAR
CONFIRMAR=AUTORIZARE
AUTORIZARE=PENDIENTE
PENDIENTE=FUERALINEA
FUERALINEA=SINCRO
SINCRO=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=ProvInfo
ProvInfo=MovPropiedades
MovPropiedades=Navegador
Navegador=Totales
Totales=Mostrar Campos
Mostrar Campos=(Fin)
