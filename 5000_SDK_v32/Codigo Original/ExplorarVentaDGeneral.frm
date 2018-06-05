[Forma]
Clave=ExplorarVentaDGeneral
Nombre=<T>Explorando - Ventas General (Detalle)<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=296
PosicionInicialArriba=166
PosicionInicialAltura=516
PosicionInicialAncho=1051
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
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ArtGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtFam
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=ArtLinea
FiltroAplicaEn1=Art.Categoria
FiltroAplicaEn2=Art.Grupo
FiltroAplicaEn3=Art.Familia
FiltroAplicaEn4=Art.Linea
FiltroAncho=25
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
BusquedaAncho=25
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
FiltroListas=S
FiltroListasRama=INV
FiltroListasAplicaEn=VentaD.Articulo
FiltroMovs=S
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=Fabricante
FiltroAplicaEn5=Art.Fabricante
FiltroGrupo6=(Validaciones Memoria)
FiltroValida6=Agente
FiltroAplicaEn6=Venta.Agente
FiltroSucursales=S
FiltroEstatus=S
IconosConSenales=S
FiltroProyectos=S
FiltroUENs=S
FiltroUENsCampo=VentaD.UEN

AnchoTotalizador1=450
TieneTotalizador2=S
IconosNombre=VentaExplorarD:Venta.Mov+<T> <T>+VentaExplorarD:Venta.MovID
FiltroGeneral=Venta.Empresa=<T>{Empresa}<T>
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
Tamano=
ColorFondo=Blanco

Totalizador=0
Totalizador2=N
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
Visible=S
ActivoCondicion=Usuario.Costos

[Acciones.Desglosar]
Nombre=Desglosar
Boton=47
NombreEnBoton=S
NombreDesplegar=&Desglosar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VerAcum
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(VentaExplorarD:VentaD.Articulo) y ConDatos(VentaExplorarD:Venta.Cliente)
AntesExpresiones=IrModulo(<T>VTAS<T>)<BR>IrDireccion(<T>VTAS<T>, VentaExplorarD:VentaD.Articulo, VentaExplorarD:Venta.Cliente)

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

[Lista.PrecioTotalNeto]
Carpeta=Lista
Clave=PrecioTotalNeto
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Lista.PrecioTotalNetoMN]
Carpeta=Lista
Clave=PrecioTotalNetoMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador2=S
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








[Lista.ListaEnCaptura]
(Inicio)=Venta.Cliente
Venta.Cliente=VentaD.Articulo
VentaD.Articulo=CantidadNeta
CantidadNeta=PrecioTotalNeto
PrecioTotalNeto=DescuentosNetos
DescuentosNetos=SubTotalNeto
SubTotalNeto=PrecioTotalNetoMN
PrecioTotalNetoMN=DescuentosNetosMN
DescuentosNetosMN=SubTotalNetoMN
SubTotalNetoMN=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=BORRADOR
BORRADOR=CONFIRMAR
CONFIRMAR=PENDIENTE
PENDIENTE=RECURRENTE
RECURRENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=PROCESAR
PROCESAR=VIGENTE
VIGENTE=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=Desglosar
Desglosar=CteInfo
CteInfo=ArtInfo
ArtInfo=MovPropiedades
MovPropiedades=Mostrar Campos
Mostrar Campos=(Fin)
