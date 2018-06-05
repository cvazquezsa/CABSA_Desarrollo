

[Forma]
Clave=ExplorarCampanaAgente
Icono=0
Modulos=CMP
MovModulo=(Todos)
Nombre=<T>Explorando - Campañas (Agente)<T>

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=431
PosicionInicialArriba=255
PosicionInicialAlturaCliente=469
PosicionInicialAncho=946
BarraHerramientas=S
EsMovimiento=S
EsConsultaExclusiva=S
TituloAuto=S
MovEspecificos=Todos
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
ListaAcciones=(Lista)
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CampanaTV
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=Agente
FiltroAplicaEn1=Campana.Agente
BusquedaRapidaControles=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSucursales=S
FiltroFechasHoras=S
FiltroFechasCampo=Campana.FechaEmision
FiltroFechasDefault=Este Mes
FiltroMovDefault=(Todos)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroTodo=S
FiltroTodoFinal=S
PestanaOtroNombre=S
PestanaNombre=Movimientos
PermiteLocalizar=S
IconosSubTitulo=<T>Movimiento<T>
ListaEnCaptura=(Lista)

FiltroListaEstatus=(Lista)
FiltroSucursalesTodasPorOmision=S
FiltroEstatusDefault=PENDIENTE
FiltroListas=S
FiltroListasRama=(Todos)
FiltroEstatus=S
IconosNombre=CampanaTV:Campana.Mov+<T> <T>+CampanaTV:Campana.MovID
FiltroGeneral=Campana.Empresa = <T>{Empresa}<T>
[Lista.Campana.FechaEmision]
Carpeta=Lista
Clave=Campana.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.Columnas]
0=-2
1=-2










2=-2
3=-2
4=-2
5=-2


[Lista.Campana.CampanaTipo]
Carpeta=Lista
Clave=Campana.CampanaTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.CampanaD.FechaD]
Carpeta=Lista
Clave=CampanaD.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CampanaD.FechaA]
Carpeta=Lista
Clave=CampanaD.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Campana.Agente]
Carpeta=Lista
Clave=Campana.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco



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

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreEnBoton=S
NombreDesplegar=&Imprimir
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
NombreDesplegar=Presentacion preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S








[Acciones.Excel]
Nombre=Excel
Boton=115
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
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S











































































































































[Lista.ListaEnCaptura]
(Inicio)=Campana.FechaEmision
Campana.FechaEmision=Campana.CampanaTipo
Campana.CampanaTipo=CampanaD.FechaD
CampanaD.FechaD=CampanaD.FechaA
CampanaD.FechaA=Campana.Agente
Campana.Agente=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=Mostrar Campos
Mostrar Campos=(Fin)
