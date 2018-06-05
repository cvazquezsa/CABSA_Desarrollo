[Forma]
Clave=ExplorarOportunidad
Nombre=<T>Explorando - Oportunidades<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=146
PosicionInicialArriba=50
PosicionInicialAltura=448
PosicionInicialAncho=972
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
OportunidadnaTipoMarco=Normal
OportunidadnaPosicionInicial=Centrado
EsMovimiento=S
TituloAuto=S
MovModulo=OPORT
MovEspecificos=Todos
PosicionInicialAlturaCliente=542
ExpresionesAlCerrar=Asigna(Filtro.Cliente, Nulo)<BR>Asigna(Filtro.Proyecto, Nulo)<BR>Asigna(Filtro.Actividad, Nulo)

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Movimientos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Oportunidad
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(Situación)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroListas=S
FiltroListasRama=CXC
FiltroListasAplicaEn=Oportunidad.Contacto
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CteCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=CteFam
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=CteGrupo
FiltroAplicaEn1=Cte.Categoria
FiltroAplicaEn2=Cte.Familia
FiltroAplicaEn3=Cte.Grupo
FiltroTodo=S
FiltroTodoFinal=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=CONCLUIDO
FiltroFechasCampo=Oportunidad.FechaEmision
FiltroFechasDefault=Este Mes
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroMovDefault=(Todos)
FiltroMonedasCampo=Oportunidad.Moneda
PermiteLocalizar=S
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=Agente
FiltroAplicaEn4=Oportunidad.Agente
FiltroArbol=Clientes
FiltroArbolAplica=Cte.Rama

AnchoTotalizador1=425
TieneTotalizador2=S



FiltroUENsCampo=UEN
IconosNombreNumerico=S
FiltroEstatus=S
FiltroUsuarios=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSituacion=S
FiltroSituacionTodo=S
FiltroSucursales=S
FiltroUsuarioSituacion=S
FiltroMonedas=S
IconosConSenales=S
IconosNombre=Oportunidad:Oportunidad.Mov+<T> <T>+Oportunidad:Oportunidad.MovID
FiltroGeneral=Oportunidad.Empresa=<T>{Empresa}<T>
[Lista.Columnas]
0=123
1=89

2=92
3=94
4=63
5=131
6=104
7=115
8=120
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
NombreDesplegar=Enviar a E&xcel
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
NombreDesplegar=C&ontacto
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CteInfo
ConCondicion=S
Antes=S
Visible=S

ActivoCondicion=Usuario.CteInfo y Vacio(Filtro.Cliente)
EjecucionCondicion=ConDatos(Oportunidad:Oportunidad.Contacto)
AntesExpresiones=Asigna(Info.Cliente, Oportunidad:Oportunidad.Contacto)
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

EjecucionCondicion=ConDatos(Oportunidad:Oportunidad.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>OPORT<T>)<BR>Asigna(Info.ID, Oportunidad:Oportunidad.ID)
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


















[Lista.Oportunidad.FechaEmision]
Carpeta=Lista
Clave=Oportunidad.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Oportunidad.ContactoTipo]
Carpeta=Lista
Clave=Oportunidad.ContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Oportunidad.Contacto]
Carpeta=Lista
Clave=Oportunidad.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Avance]
Carpeta=Lista
Clave=Avance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Oportunidad.ImporteOportunidad]
Carpeta=Lista
Clave=Oportunidad.ImporteOportunidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco














[Lista.ListaEnCaptura]
(Inicio)=Oportunidad.FechaEmision
Oportunidad.FechaEmision=Oportunidad.ContactoTipo
Oportunidad.ContactoTipo=Oportunidad.Contacto
Oportunidad.Contacto=Avance
Avance=Oportunidad.ImporteOportunidad
Oportunidad.ImporteOportunidad=(Fin)

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
Excel=CteInfo
CteInfo=MovPropiedades
MovPropiedades=Mostrar Campos
Mostrar Campos=(Fin)
