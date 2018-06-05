[Forma]
Clave=ExplorarVentaPendienteAgente
Nombre=<T>Explorando - Ventas Pendientes por Agente<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=8
PosicionInicialArriba=195
PosicionInicialAltura=464
PosicionInicialAncho=797
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
EsMovimiento=S
TituloAuto=S
MovModulo=VTAS
MovEspecificos=Todos
PosicionInicialAlturaCliente=437

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaPendiente
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
FiltroGrupo1=VentaPendiente.Agente
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
BusquedaAncho=20
BusquedaEnLinea=S
FiltroListasRama=CXC
FiltroListasAplicaEn=VentaPendiente.Cliente
FiltroMonedas=S
FiltroMonedasCampo=VentaPendiente.Moneda
PermiteLocalizar=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroMovDefault=(Todos)
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
FiltroFechas=S
FiltroFechasCampo=VentaPendiente.FechaRequerida
FiltroFechasDefault=(Todo)
FiltroUENs=S
FiltroUENsCampo=VentaPendiente.UEN
FiltroProyectos=S
FiltroFechasNombre=&Fecha Requerida

TieneTotalizador2=S
AnchoTotalizador1=300
IconosNombre=VentaPendiente:VentaPendiente.Mov+<T> <T>+VentaPendiente:VentaPendiente.MovID
FiltroGeneral=VentaPendiente.Empresa=<T>{Empresa}<T>
[Lista.VentaPendiente.FechaEmision]
Carpeta=Lista
Clave=VentaPendiente.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.VentaPendiente.Cliente]
Carpeta=Lista
Clave=VentaPendiente.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.VentaPendiente.Saldo]
Carpeta=Lista
Clave=VentaPendiente.Saldo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Columnas]
0=127
1=79

2=-2
3=-2
4=-2
5=-2
6=-2
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

[Lista.VentaPendiente.FechaRequerida]
Carpeta=Lista
Clave=VentaPendiente.FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.Cte.NombreCorto]
Carpeta=Lista
Clave=Cte.NombreCorto
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
EjecucionCondicion=ConDatos(VentaPendiente:VentaPendiente.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, VentaPendiente:VentaPendiente.ID)
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







[Lista.SaldoMN]
Carpeta=Lista
Clave=SaldoMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco


[Lista.ListaEnCaptura]
(Inicio)=VentaPendiente.Cliente
VentaPendiente.Cliente=Cte.NombreCorto
Cte.NombreCorto=VentaPendiente.FechaEmision
VentaPendiente.FechaEmision=VentaPendiente.FechaRequerida
VentaPendiente.FechaRequerida=VentaPendiente.Saldo
VentaPendiente.Saldo=SaldoMN
SaldoMN=(Fin)

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
