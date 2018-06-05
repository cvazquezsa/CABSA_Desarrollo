[Forma]
Clave=ExplorarAgentVentaD
Nombre=<T>Explorando - Ventas por Agente<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=0
PosicionInicialArriba=169
PosicionInicialAltura=516
PosicionInicialAncho=1170
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
MovEspecificos=Todos
PosicionInicialAlturaCliente=489

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaExplorarD
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
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=VentaD.Agente
FiltroValida1=VentaD.Agente
FiltroAncho=20
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroTodoFinal=S
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroFechas=S
FiltroMonedas=S
FiltroFechasCampo=Venta.FechaEmision
FiltroFechasDefault=Este Mes
FiltroMonedasCampo=Venta.Moneda
FiltroMovsTodos=S
FiltroMovDefault=(Todos)
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=CONCLUIDO
PermiteLocalizar=S
FiltroListasRama=INV
FiltroListasAplicaEn=VentaD.Articulo
FiltroMovs=S
FiltroSucursales=S

AnchoTotalizador1=550
TieneTotalizador2=S
IconosNombre=VentaExplorarD:Venta.Mov+<T> <T>+VentaExplorarD:Venta.MovID
FiltroGeneral=Venta.Empresa=<T>{Empresa}<T> AND<BR>Venta.Estatus IN (<T>PENDIENTE<T>, <T>CONCLUIDO<T>) AND<BR>Venta.Mov IN ({MovListaSQL(<T>VTAS<T>, VTAS.F, VTAS.FAR, VTAS.FB, VTAS.FM, VTAS.D, VTAS.DF, VTAS.B)})
[Lista.VentaD.Articulo]
Carpeta=Lista
Clave=VentaD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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

[Lista.Columnas]
0=125
1=87

2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
9=-2
10=-2
11=-2
12=-2
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
NombreDesplegar=Enviar a Excel
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
TipoAccion=Formas
ClaveAccion=CteInfo
ActivoCondicion=Usuario.CteInfo
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(VentaExplorarD:Venta.Cliente)
AntesExpresiones=Asigna(Info.Cliente, VentaExplorarD:Venta.Cliente)

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
NombreDesplegar=&Artículo
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
NombreEnBoton=S
EjecucionCondicion=ConDatos(VentaExplorarD:VentaD.Articulo)
AntesExpresiones=Asigna(Info.Articulo, VentaExplorarD:VentaD.Articulo)

[Lista.DescuentosNetos]
Carpeta=Lista
Clave=DescuentosNetos
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.SubTotalNeto]
Carpeta=Lista
Clave=SubTotalNeto
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CantidadNeta]
Carpeta=Lista
Clave=CantidadNeta
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

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
EjecucionCondicion=ConDatos(VentaExplorarD:Venta.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, VentaExplorarD:Venta.ID)

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

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

[Lista.ComisionNeta]
Carpeta=Lista
Clave=ComisionNeta
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.AgenteInfo]
Nombre=AgenteInfo
Boton=34
NombreEnBoton=S
NombreDesplegar=Agen&te
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=AgenteInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(VentaExplorarD:VentaD.Agente)
AntesExpresiones=Asigna(Info.Agente, VentaExplorarD:VentaD.Agente)

[Lista.PrecioTotalNeto]
Carpeta=Lista
Clave=PrecioTotalNeto
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VentaD.Agente]
Carpeta=Lista
Clave=VentaD.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco




[Lista.PrecioTotalNetoMN]
Carpeta=Lista
Clave=PrecioTotalNetoMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco

[Lista.DescuentosNetosMN]
Carpeta=Lista
Clave=DescuentosNetosMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco

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

[Lista.ComisionNetaMN]
Carpeta=Lista
Clave=ComisionNetaMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco


[Lista.ListaEnCaptura]
(Inicio)=Venta.Cliente
Venta.Cliente=VentaD.Agente
VentaD.Agente=VentaD.Articulo
VentaD.Articulo=CantidadNeta
CantidadNeta=PrecioTotalNeto
PrecioTotalNeto=DescuentosNetos
DescuentosNetos=SubTotalNeto
SubTotalNeto=ComisionNeta
ComisionNeta=PrecioTotalNetoMN
PrecioTotalNetoMN=DescuentosNetosMN
DescuentosNetosMN=SubTotalNetoMN
SubTotalNetoMN=ComisionNetaMN
ComisionNetaMN=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=CteInfo
CteInfo=AgenteInfo
AgenteInfo=ArtInfo
ArtInfo=MovPropiedades
MovPropiedades=Mostrar Campos
Mostrar Campos=(Fin)
