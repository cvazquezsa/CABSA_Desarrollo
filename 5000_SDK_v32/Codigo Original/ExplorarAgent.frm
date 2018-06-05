[Forma]
Clave=ExplorarAgent
Nombre=Explorando - Comisiones y Destajos
Icono=47
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=20
PosicionInicialArriba=153
PosicionInicialAltura=549
PosicionInicialAncho=772
EsMovimiento=S
TituloAuto=S
MovModulo=AGENT
MovEspecificos=Todos
EsConsultaExclusiva=S

PosicionInicialAlturaCliente=522
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

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Movimientos
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Agent
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroGrupo1=Agent.Agente
FiltroValida1=Agent.Agente
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroTodoFinal=S
FiltroAncho=20
FiltroAplicaEn=Agent.Agente
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroMonedas=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=(Todos)
FiltroFechasCampo=Agent.FechaEmision
FiltroFechasDefault=Este Mes
FiltroFechasNormal=S
FiltroMonedasCampo=Agent.Moneda
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S
FiltroMovsTodos=S
FiltroMovDefault=(Todos)
FiltroSucursales=S

AnchoTotalizador1=300
TieneTotalizador2=S
IconosNombre=Agent:Agent.Mov+<T> <T>+Agent:Agent.MovID
FiltroGeneral=Agent.Empresa=<T>{Empresa}<T> AND<BR>Agent.Estatus IN (<T>PENDIENTE<T>, <T>CONCLUIDO<T>) AND<BR>Agent.Mov IN ({MovListaSQL(<T>AGENT<T>, AGENT.C, AGENT.D)})
[Lista.Agent.Agente]
Carpeta=Lista
Clave=Agent.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Agent.FechaEmision]
Carpeta=Lista
Clave=Agent.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Agent.Referencia]
Carpeta=Lista
Clave=Agent.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
0=133
1=76

2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
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

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Lista.ImporteNeto]
Carpeta=Lista
Clave=ImporteNeto
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.SaldoNeto]
Carpeta=Lista
Clave=SaldoNeto
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=Propiedades
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Agent:Agent.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>AGENT<T>)<BR>Asigna(Info.ID, Agent:Agent.ID)
Visible=S

[Acciones.Informacion]
Nombre=Informacion
Boton=34
NombreDesplegar=Información
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=AgenteInfo
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Agent:Agent.Agente)
Antes=S
AntesExpresiones=Asigna(Info.Agente, Agent:Agent.Agente)
Visible=S




[Lista.ImporteNetoMN]
Carpeta=Lista
Clave=ImporteNetoMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco

[Lista.SaldoNetoMN]
Carpeta=Lista
Clave=SaldoNetoMN
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador2=S
ColorFondo=Blanco


[Lista.ListaEnCaptura]
(Inicio)=Agent.Agente
Agent.Agente=Agent.FechaEmision
Agent.FechaEmision=Agent.Referencia
Agent.Referencia=ImporteNeto
ImporteNeto=SaldoNeto
SaldoNeto=ImporteNetoMN
ImporteNetoMN=SaldoNetoMN
SaldoNetoMN=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Propiedades
Propiedades=Informacion
Informacion=Campos
Campos=(Fin)
