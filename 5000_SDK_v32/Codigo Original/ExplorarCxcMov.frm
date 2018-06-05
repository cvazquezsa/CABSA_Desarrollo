[Forma]
Clave=ExplorarCxcMov
Nombre=<T>Explorando - Cuentas por Cobrar (Movimientos)<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=196
PosicionInicialArriba=110
PosicionInicialAltura=496
PosicionInicialAncho=973
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=469

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxcExplorar
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=20
FiltroListas=S
FiltroListasRama=CXC
FiltroListasAplicaEn=Cte.Cliente
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CteCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=CteFam
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=CteGrupo
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroTodoFinal=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Pendientes
MenuLocal=S
ListaAcciones=LocalInformacion
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=CxcInfo.Vencimiento
FiltroFechasDefault=(Todo)
FiltroFechasVencimiento=S
OtroOrden=S
ListaOrden=CxcInfo.Vencimiento<TAB>(Acendente)
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroAplicaEn1=Cte.Categoria
FiltroAplicaEn2=Cte.Familia
FiltroAplicaEn3=Cte.Grupo
FiltroMonedas=S
FiltroMonedasCampo=CxcInfo.Moneda
PermiteLocalizar=S
FiltroMovsTodos=S
FiltroMovDefault=(Todos)
BusquedaRespetarControles=S
FiltroProyectos=S
FiltroUENs=S
FiltroUENsCampo=CxcInfo.UEN

AnchoTotalizador1=400
TieneTotalizador2=S
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=CteTipo
FiltroAplicaEn4=Cte.Tipo
IconosNombre=CxcExplorar:CxcInfo.Mov+<T> <T>+CxcExplorar:CxcInfo.MovID
FiltroGeneral=CxcInfo.Empresa=<T>{Empresa}<T>
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

[Lista.Columnas]
Cliente=106
Nombre=314
Saldo=106
0=120
1=97

2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=96
[Acciones.Informacion]
Nombre=Informacion
Boton=34
NombreEnBoton=S
NombreDesplegar=C&liente
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CteInfo
Antes=S
Visible=S
ConCondicion=S
EspacioPrevio=S

ActivoCondicion=Usuario.CteInfo
EjecucionCondicion=ConDatos(CxcExplorar:CxcInfo.Cliente)
AntesExpresiones=Asigna( Info.Cliente, CxcExplorar:CxcInfo.Cliente)
[Acciones.LocalInformacion]
Nombre=LocalInformacion
Boton=0
NombreDesplegar=&Información del Cliente
EnMenu=S
TipoAccion=Formas
ClaveAccion=CteInfo
Activo=S
Antes=S
Visible=S

AntesExpresiones=Asigna( Info.Cliente, CxcExplorar:CxcInfo.Cliente)
[Lista.CxcInfo.Referencia]
Carpeta=Lista
Clave=CxcInfo.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.CxcInfo.Saldo]
Carpeta=Lista
Clave=CxcInfo.Saldo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
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

[Lista.CxcInfo.Cliente]
Carpeta=Lista
Clave=CxcInfo.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Dias]
Carpeta=Lista
Clave=Dias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CxcInfo.FechaEmision]
Carpeta=Lista
Clave=CxcInfo.FechaEmision
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

[Lista.CxcInfo.Vencimiento]
Carpeta=Lista
Clave=CxcInfo.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Reporte]
Nombre=Reporte
Boton=68
NombreDesplegar=Reporte
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=RepCxcPendiente
Activo=S
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
(Inicio)=CxcInfo.Cliente
CxcInfo.Cliente=Cte.NombreCorto
Cte.NombreCorto=CxcInfo.Referencia
CxcInfo.Referencia=CxcInfo.FechaEmision
CxcInfo.FechaEmision=Dias
Dias=CxcInfo.Vencimiento
CxcInfo.Vencimiento=CxcInfo.Saldo
CxcInfo.Saldo=SaldoMN
SaldoMN=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=Reporte
Reporte=Informacion
Informacion=Mostrar Campos
Mostrar Campos=(Fin)
