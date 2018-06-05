[Forma]
Clave=ExplorarCompraPendiente
Nombre=<T>Explorando - Compras Pendientes<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=42
PosicionInicialArriba=192
PosicionInicialAltura=470
PosicionInicialAncho=728
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=443

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraPendiente
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
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
PestanaOtroNombre=S
PestanaNombre=Movimientos
FiltroGrupo1=CompraPendiente.Proveedor
FiltroValida1=CompraPendiente.Proveedor
FiltroTodo=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroListasRama=CXP
FiltroListasAplicaEn=CompraPendiente.Proveedor
FiltroTodoFinal=S
PermiteLocalizar=S
FiltroFechas=S
FiltroFechasCampo=CompraPendiente.FechaRequerida
FiltroFechasDefault=(Todo)
FiltroFechasVencimiento=S
FiltroMonedas=S
FiltroMonedasCampo=CompraPendiente.Moneda
FiltroProyectos=S
FiltroFechasNombre=&Fecha Requerida
FiltroUENs=S
FiltroUENsCampo=CompraPendiente.UEN

AnchoTotalizador1=200
TieneTotalizador2=S
IconosNombre=CompraPendiente:CompraPendiente.Mov+<T> <T>+CompraPendiente:CompraPendiente.MovID
FiltroGeneral=CompraPendiente.Empresa=<T>{Empresa}<T>
[Lista.CompraPendiente.FechaEmision]
Carpeta=Lista
Clave=CompraPendiente.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.CompraPendiente.Saldo]
Carpeta=Lista
Clave=CompraPendiente.Saldo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.CompraPendiente.Moneda]
Carpeta=Lista
Clave=CompraPendiente.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Columnas]
0=135
1=87

2=-2
3=-2
4=-2
5=-2
6=-2
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

[Lista.CompraPendiente.Proveedor]
Carpeta=Lista
Clave=CompraPendiente.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

Totalizador=0
Totalizador2=N
[Lista.CompraPendiente.FechaRequerida]
Carpeta=Lista
Clave=CompraPendiente.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
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
EjecucionCondicion=ConDatos(CompraPendiente:CompraPendiente.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>COMS<T>)<BR>Asigna(Info.ID, CompraPendiente:CompraPendiente.ID)

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


[Lista.SaldoMN]
Carpeta=Lista
Clave=SaldoMN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


Totalizador=1
Totalizador2=S



[Lista.ListaEnCaptura]
(Inicio)=CompraPendiente.Proveedor
CompraPendiente.Proveedor=CompraPendiente.FechaEmision
CompraPendiente.FechaEmision=CompraPendiente.FechaRequerida
CompraPendiente.FechaRequerida=CompraPendiente.Saldo
CompraPendiente.Saldo=CompraPendiente.Moneda
CompraPendiente.Moneda=SaldoMN
SaldoMN=(Fin)





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=MovPropiedades
MovPropiedades=Mostrar Campos
Mostrar Campos=(Fin)
