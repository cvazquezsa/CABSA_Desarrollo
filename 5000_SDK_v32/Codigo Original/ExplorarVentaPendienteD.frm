[Forma]
Clave=ExplorarVentaPendienteD
Nombre=<T>Explorando - Ventas Pendientes (Detalle)<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=0
PosicionInicialArriba=203
PosicionInicialAltura=449
PosicionInicialAncho=944
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
EsMovimiento=S
TituloAuto=S
MovModulo=VTAS
MovEspecificos=Todos
PosicionInicialAlturaCliente=422

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaPendienteD
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
FiltroPredefinido=S
FiltroAncho=25
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
PestanaOtroNombre=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtCat
FiltroTodo=S
FiltroTodoFinal=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=25
BusquedaEnLinea=S
FiltroListas=S
FiltroListasRama=INV
FiltroListasAplicaEn=VentaPendienteD.Articulo
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
FiltroMonedas=S
FiltroMonedasCampo=VentaPendienteD.Moneda
PermiteLocalizar=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroMovDefault=(Todos)
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
FiltroFechas=S
FiltroFechasCampo=VentaPendienteD.FechaRequerida
FiltroFechasDefault=(Todo)
FiltroArbol=Articulos
FiltroArbolAplica=Art.Rama
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=Fabricante
FiltroAplicaEn5=Art.Fabricante
FiltroGrupo6=(Validaciones Memoria)
FiltroValida6=Agente
FiltroAplicaEn6=VentaPendienteD.Agente
FiltroUENs=S
FiltroUENsCampo=VentaPendienteD.UEN
FiltroProyectos=S
FiltroSucursales=S

TieneTotalizador2=S
AnchoTotalizador1=500
IconosNombre=VentaPendienteD:VentaPendienteD.Mov+<T> <T>+VentaPendienteD:VentaPendienteD.MovID
FiltroGeneral=VentaPendienteD.Empresa=<T>{Empresa}<T>
[Lista.Columnas]
0=97
1=89

2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
[Lista.VentaPendiente.Total]
Carpeta=Lista
Clave=VentaPendiente.Total
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

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

[Lista.ImportePendiente]
Carpeta=Lista
Clave=ImportePendiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
Totalizador=1
ColorFondo=Blanco

[Lista.VentaPendienteD.Cliente]
Carpeta=Lista
Clave=VentaPendienteD.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.VentaPendienteD.Articulo]
Carpeta=Lista
Clave=VentaPendienteD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

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
EjecucionCondicion=ConDatos(VentaPendienteD:VentaPendienteD.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, VentaPendienteD:VentaPendienteD.ID)
Visible=S

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

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.VentaPendienteD.ReservadaFactor]
Carpeta=Lista
Clave=VentaPendienteD.ReservadaFactor
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VentaPendienteD.OrdenadaFactor]
Carpeta=Lista
Clave=VentaPendienteD.OrdenadaFactor
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VentaPendienteD.PendienteFactor]
Carpeta=Lista
Clave=VentaPendienteD.PendienteFactor
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco







[Lista.ImportePendienteMN]
Carpeta=Lista
Clave=ImportePendienteMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco





[Lista.ListaEnCaptura]
(Inicio)=VentaPendienteD.Cliente
VentaPendienteD.Cliente=VentaPendienteD.Articulo
VentaPendienteD.Articulo=Art.Descripcion1
Art.Descripcion1=VentaPendienteD.ReservadaFactor
VentaPendienteD.ReservadaFactor=VentaPendienteD.OrdenadaFactor
VentaPendienteD.OrdenadaFactor=VentaPendienteD.PendienteFactor
VentaPendienteD.PendienteFactor=ImportePendiente
ImportePendiente=ImportePendienteMN
ImportePendienteMN=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=PENDIENTE
PENDIENTE=CONFIRMAR
CONFIRMAR=(Fin)





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=MovPropiedades
MovPropiedades=Mostrar Campos
Mostrar Campos=(Fin)
