[Forma]
Clave=ExplorarVenta
Nombre=<T>Explorando - Ventas<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=116
PosicionInicialArriba=134
PosicionInicialAltura=448
PosicionInicialAncho=1134
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
EsMovimiento=S
TituloAuto=S
MovModulo=VTAS
MovEspecificos=Especificos
PosicionInicialAlturaCliente=421
Comentarios=Filtro.Cliente
ExpresionesAlCerrar=Asigna(Filtro.Cliente, Nulo)<BR>Asigna(Filtro.Proyecto, Nulo)<BR>Asigna(Filtro.Actividad, Nulo)

MovimientosValidos=(Lista)
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
Vista=VentaExplorar
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
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroListas=S
FiltroListasRama=CXC
FiltroListasAplicaEn=Venta.Cliente
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CteCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=CteFam
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=CteGrupo
FiltroAplicaEn1=Cte.Categoria
FiltroAplicaEn2=Cte.Familia
FiltroAplicaEn3=Cte.Grupo
FiltroTodo=S
FiltroTodoFinal=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=CONCLUIDO
FiltroFechasCampo=Venta.FechaEmision
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
FiltroMonedasCampo=Venta.Moneda
PermiteLocalizar=S
FiltroMovs=S
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=Agente
FiltroAplicaEn4=Venta.Agente
FiltroArbol=Clientes
FiltroArbolAplica=Cte.Rama
FiltroSucursales=S
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=PaisEstadoMexico
FiltroAplicaEn5=Cte.Estado
FiltroProyectos=S

AnchoTotalizador1=425
TieneTotalizador2=S
OtroOrden=S
IconosNombre=VentaExplorar:Venta.Mov+<T> <T>+VentaExplorar:Venta.MovID
ListaOrden=Venta.ID<TAB>(Acendente)
Paginacion=S
PaginacionTamano=1000
FiltroGeneral=Venta.Empresa=<T>{Empresa}<T> AND<BR>Venta.Estatus IN (<T>PENDIENTE<T>, <T>CONCLUIDO<T>) AND<BR>Venta.Mov IN ({MovListaSQL(<T>VTAS<T>, VTAS.F, VTAS.FAR, VTAS.FB, VTAS.FM, VTAS.D, VTAS.DF, VTAS.B)})<BR>{Si(ConDatos(Filtro.Cliente), <T> AND Venta.Cliente=<T>+Comillas(Filtro.Cliente), <T><T>)}
[Lista.Venta.FechaEmision]
Carpeta=Lista
Clave=Venta.FechaEmision
Editar=S
Totalizador=0
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

[Lista.Venta.Almacen]
Carpeta=Lista
Clave=Venta.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Columnas]
0=127
1=81

2=-2
3=-2
4=-2
5=83
6=104
7=115
8=120
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
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.CteInfo]
Nombre=CteInfo
Boton=34
NombreEnBoton=S
NombreDesplegar=C&liente
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CteInfo
ConCondicion=S
Antes=S
Visible=S
ActivoCondicion=Usuario.CteInfo y Vacio(Filtro.Cliente)
EjecucionCondicion=ConDatos(VentaExplorar:Venta.Cliente)
AntesExpresiones=Asigna(Info.Cliente, VentaExplorar:Venta.Cliente)

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
EjecucionCondicion=ConDatos(VentaExplorar:Venta.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, VentaExplorar:Venta.ID)

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=ExplorarVentaTotales
Activo=S
Visible=S

Antes=S
AntesExpresiones=Asigna(Info.Filtro,<T> where <T> & Carpeta.FiltroActual( <T>Lista<T> ))<BR>Asigna(Info.Valor,<T> <T> & Carpeta.FiltroActual( <T>Lista<T> ))
[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Impresora
ClaveAccion=ExplorarVentaTotales
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
TipoAccion=Herramientas Captura
ClaveAccion=Navegador Paginacion
Activo=S
Visible=S


EspacioPrevio=S
[Acciones.Totales]
Nombre=Totales
Boton=64
NombreEnBoton=S
NombreDesplegar=Totales
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ExplorarVentaTotal
Activo=S
Visible=S






Antes=S
AntesExpresiones=Asigna(Info.Filtro,<T> where <T> & Carpeta.FiltroActual( <T>Lista<T> ))<BR>Asigna(Info.Valor,<T> <T> & Carpeta.FiltroActual( <T>Lista<T> ))
[Lista.ListaEnCaptura]
(Inicio)=Venta.FechaEmision
Venta.FechaEmision=Venta.Cliente
Venta.Cliente=Venta.Almacen
Venta.Almacen=SubTotalNeto
SubTotalNeto=ImpuestosNetos
ImpuestosNetos=ImporteTotalNeto
ImporteTotalNeto=SubTotalNetoMN
SubTotalNetoMN=ImpuestosNetosMN
ImpuestosNetosMN=ImporteTotalNetoMN
ImporteTotalNetoMN=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)


























[Forma.MovimientosValidos]
(Inicio)=Bonificacion Venta
Bonificacion Venta=Cancelacion Factura
Cancelacion Factura=Dev. Referenciada
Dev. Referenciada=Devolucion Credito
Devolucion Credito=Devolucion Venta
Devolucion Venta=Devolucion Faltante
Devolucion Faltante=Factura
Factura=Factura Credito
Factura Credito=Factura Flexible
Factura Flexible=Factura Prorrateada
Factura Prorrateada=Recarga Tarjeta
Recarga Tarjeta=Factura Mostrador
Factura Mostrador=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=CteInfo
CteInfo=MovPropiedades
MovPropiedades=Navegador
Navegador=Totales
Totales=Mostrar Campos
Mostrar Campos=(Fin)
