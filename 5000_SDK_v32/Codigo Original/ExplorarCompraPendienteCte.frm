[Forma]
Clave=ExplorarCompraPendienteCte
Nombre=<T>Explorando - Compras Pendientes por Cliente<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=0
PosicionInicialArriba=183
PosicionInicialAltura=489
PosicionInicialAncho=976
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=462

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraPendienteD
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
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin asignar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
PestanaOtroNombre=S
FiltroGrupo1=CompraPendienteD.Cliente
FiltroValida1=CompraPendienteD.Cliente
FiltroTodo=S
FiltroTodoFinal=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
PermiteLocalizar=S
FiltroNull=S
FiltroFechas=S
FiltroMonedas=S
FiltroFechasCampo=CompraPendienteD.FechaEntrega
FiltroFechasDefault=(Todo)
FiltroFechasVencimiento=S
FiltroMonedasCampo=CompraPendienteD.Moneda
FiltroProyectos=S
FiltroFechasNombre=&Fecha Requerida
FiltroUENs=S
FiltroUENsCampo=CompraPendienteD.UEN

AnchoTotalizador1=550
TieneTotalizador2=S
IconosNombre=CompraPendienteD:CompraPendienteD.Mov+<T> <T>+CompraPendienteD:CompraPendienteD.MovID
FiltroGeneral=CompraPendienteD.Empresa=<T>{Empresa}<T>
[Lista.Columnas]
0=114
1=65

2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
9=-2
10=-2
[Lista.CompraPendiente.Total]
Carpeta=Lista
Clave=CompraPendiente.Total
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
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.CompraPendienteD.Proveedor]
Carpeta=Lista
Clave=CompraPendienteD.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco

Totalizador=1
Totalizador2=S
[Lista.CompraPendienteD.Articulo]
Carpeta=Lista
Clave=CompraPendienteD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.CompraPendienteD.FechaEntrega]
Carpeta=Lista
Clave=CompraPendienteD.FechaEntrega
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CompraPendienteD.Referencia]
Carpeta=Lista
Clave=CompraPendienteD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Dias]
Carpeta=Lista
Clave=Dias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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
EjecucionCondicion=ConDatos(CompraPendienteD:CompraPendienteD.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, CompraPendienteD:CompraPendienteD.ID)

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

[Lista.CompraPendienteD.PendienteFactor]
Carpeta=Lista
Clave=CompraPendienteD.PendienteFactor
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.CompraPendienteD.Cliente]
Carpeta=Lista
Clave=CompraPendienteD.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco



[Lista.ImportePendienteMN]
Carpeta=Lista
Clave=ImportePendienteMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Lista.ListaEnCaptura]
(Inicio)=CompraPendienteD.Proveedor
CompraPendienteD.Proveedor=CompraPendienteD.FechaEntrega
CompraPendienteD.FechaEntrega=Dias
Dias=CompraPendienteD.Cliente
CompraPendienteD.Cliente=CompraPendienteD.Referencia
CompraPendienteD.Referencia=CompraPendienteD.Articulo
CompraPendienteD.Articulo=Art.Descripcion1
Art.Descripcion1=CompraPendienteD.PendienteFactor
CompraPendienteD.PendienteFactor=ImportePendiente
ImportePendiente=ImportePendienteMN
ImportePendienteMN=(Fin)





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=MovPropiedades
MovPropiedades=Mostrar Campos
Mostrar Campos=(Fin)
