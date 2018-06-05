[Forma]
Clave=ExplorarVentaPendienteCte
Nombre=<T>Explorado - Ventas Pendientes por Cliente (Detalle)<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=0
PosicionInicialArriba=203
PosicionInicialAltura=449
PosicionInicialAncho=914
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
Vista=VentaPendienteDisponible
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
FiltroAncho=15
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
PestanaOtroNombre=S
PestanaNombre=Pendientes
FiltroGrupo1=VentaPendienteD.Cliente
FiltroValida1=VentaPendienteD.Cliente
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
BusquedaAncho=15
BusquedaEnLinea=S
FiltroListasRama=INV
FiltroListasAplicaEn=VentaPendienteD.Articulo
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
FiltroProyectos=S
FiltroUENs=S
FiltroUENsCampo=VentaPendienteD.UEN
FiltroSucursales=S

TieneTotalizador2=S
AnchoTotalizador1=400
IconosNombre=VentaPendienteDisponible:VentaPendienteD.Mov+<T> <T>+VentaPendienteDisponible:VentaPendienteD.MovID
FiltroGeneral=VentaPendienteD.Empresa=<T>{Empresa}<T>
[Lista.Columnas]
0=102
1=79

2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
9=-2
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
Antes=S
Visible=S
EjecucionCondicion=ConDatos(VentaPendienteDisponible:VentaPendienteD.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, VentaPendienteDisponible:VentaPendienteD.ID)

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

[Lista.VentaPendienteD.PendienteFactor]
Carpeta=Lista
Clave=VentaPendienteD.PendienteFactor
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ImportePendiente]
Carpeta=Lista
Clave=ImportePendiente
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
NombreEnBoton=S
NombreDesplegar=&Artículo
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(VentaPendienteDisponible:VentaPendienteD.Articulo)
Antes=S
AntesExpresiones=Asigna(Info.Articulo, VentaPendienteDisponible:VentaPendienteD.Articulo)

[Lista.ArtDisponible.Disponible]
Carpeta=Lista
Clave=ArtDisponible.Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtAsignadoCte.Asignado]
Carpeta=Lista
Clave=ArtAsignadoCte.Asignado
Editar=S
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
VentaPendienteD.ReservadaFactor=VentaPendienteD.PendienteFactor
VentaPendienteD.PendienteFactor=ImportePendiente
ImportePendiente=ArtDisponible.Disponible
ArtDisponible.Disponible=ArtAsignadoCte.Asignado
ArtAsignadoCte.Asignado=ImportePendienteMN
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
MovPropiedades=ArtInfo
ArtInfo=Mostrar Campos
Mostrar Campos=(Fin)
