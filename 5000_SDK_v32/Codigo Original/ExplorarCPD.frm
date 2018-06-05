[Forma]
Clave=ExplorarCPD
Nombre=<T>Explorando - Movimientos Control Presupuestal a Nivel Detalle<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=489
PosicionInicialAncho=1014
PosicionInicialIzquierda=293
PosicionInicialArriba=171
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

EsMovimiento=S
MovModulo=CP
TituloAuto=S
MovEspecificos=Todos
MovimientosValidos=Operacion
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CPT
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Movimientos
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroUsuarios=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSituacion=S
FiltroMonedas=S
FiltroSucursales=S
FiltroUENs=S
FiltroUENsCampo=CP.UEN
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=CONCLUIDO
FiltroUsuarioDefault=(Todos)
FiltroFechasCampo=CP.FechaEmision
FiltroFechasDefault=Esta Semana
FiltroFechasNormal=S
FiltroMonedasCampo=CP.Moneda
FiltroFechasCancelacion=CP.FechaCancelacion
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroGrupo1=CP.Proyecto
FiltroValida1=CP.Proyecto
FiltroAutoCampo=CP.Proyecto
FiltroAutoValidar=CP.Proyecto

AnchoTotalizador1=800



FiltroTodo=S
FiltroGrupo2=CPD.ClavePresupuestal
FiltroValida2=CPD.ClavePresupuestal
FiltroMovs=S
FiltroMovsTodos=S
FiltroMovDefault=(Todos)
TieneTotalizador2=S
FiltroProyectos=S
IconosNombre=CPT:CP.Mov+<T> <T>+CPT:CP.MovID
FiltroGeneral=CP.Empresa=<T>{Empresa}<T>
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
0=93
1=79

2=124
3=52
4=54
5=91
6=105
7=-2
8=-2
9=-2
10=-2
11=-2
12=-2
13=-2
14=-2
15=-2
16=-2
17=-2
18=-2
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

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
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

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Info]
Nombre=Info
Boton=34
NombreDesplegar=Información del Proyecto
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ProyInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S






EjecucionCondicion=ConDatos(CPT:CP.Proyecto)
AntesExpresiones=Asigna(Info.Proyecto, CPT:CP.Proyecto)
[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=Propiedades
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(CRT:CR.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CR<T>)<BR>Asigna(Info.ID, CRT:CR.ID)




[Lista.CP.FechaEmision]
Carpeta=Lista
Clave=CP.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.CPD.ClavePresupuestal]
Carpeta=Lista
Clave=CPD.ClavePresupuestal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco














[Lista.OrigenNombre]
Carpeta=Lista
Clave=OrigenNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco











[Lista.CPD.Tipo]
Carpeta=Lista
Clave=CPD.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.CPD.Importe]
Carpeta=Lista
Clave=CPD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=0
[Lista.CPD.Presupuesto]
Carpeta=Lista
Clave=CPD.Presupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Lista.CPD.Comprometido]
Carpeta=Lista
Clave=CPD.Comprometido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Lista.CPD.Comprometido2]
Carpeta=Lista
Clave=CPD.Comprometido2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Lista.CPD.Devengado]
Carpeta=Lista
Clave=CPD.Devengado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Lista.CPD.Devengado2]
Carpeta=Lista
Clave=CPD.Devengado2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Lista.CPD.Ejercido]
Carpeta=Lista
Clave=CPD.Ejercido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
Totalizador2=N
[Lista.CPD.EjercidoPagado]
Carpeta=Lista
Clave=CPD.EjercidoPagado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
Totalizador2=S
[Lista.CPD.Sobrante]
Carpeta=Lista
Clave=CPD.Sobrante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
Totalizador2=S
[Lista.CPD.Anticipos]
Carpeta=Lista
Clave=CPD.Anticipos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
Totalizador2=S
[Lista.CPD.RemanenteDisponible]
Carpeta=Lista
Clave=CPD.RemanenteDisponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
Totalizador2=S

[Lista.OrigenModulo]
Carpeta=Lista
Clave=OrigenModulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





















[Lista.ListaEnCaptura]
(Inicio)=CP.FechaEmision
CP.FechaEmision=CP.Proyecto
CP.Proyecto=CP.UEN
CP.UEN=OrigenModulo
OrigenModulo=OrigenNombre
OrigenNombre=CPD.ClavePresupuestal
CPD.ClavePresupuestal=CPD.Tipo
CPD.Tipo=CPD.Importe
CPD.Importe=CPD.Presupuesto
CPD.Presupuesto=CPD.Comprometido
CPD.Comprometido=CPD.Comprometido2
CPD.Comprometido2=CPD.Devengado
CPD.Devengado=CPD.Devengado2
CPD.Devengado2=CPD.Ejercido
CPD.Ejercido=CPD.EjercidoPagado
CPD.EjercidoPagado=CPD.Sobrante
CPD.Sobrante=CPD.Anticipos
CPD.Anticipos=CPD.RemanenteDisponible
CPD.RemanenteDisponible=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=CONCLUIDO
CONCLUIDO=PENDIENTE
PENDIENTE=CANCELADO
CANCELADO=(Fin)

[Lista.CP.Proyecto]
Carpeta=Lista
Clave=CP.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.CP.UEN]
Carpeta=Lista
Clave=CP.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco









[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Propiedades
Propiedades=Info
Info=Personalizar
Personalizar=(Fin)
