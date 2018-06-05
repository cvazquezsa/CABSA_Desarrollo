
[Forma]
Clave=ExplorarGestion2
Icono=47
Modulos=(Todos)

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=426
PosicionInicialAncho=913
PosicionInicialIzquierda=263
PosicionInicialArriba=223
MovModulo=GES
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Nombre=<T>Explorando - Gestion<T>
ListaAcciones=(Lista)
[Lista]
Estilo=Iconos
Clave=Lista
Zona=A1
Vista=ExplorarGestion2
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S









Filtros=S
FiltroPredefinido=S
FiltroGrupo1=Gestion.Mov
FiltroValida1=Gestion.Mov
FiltroNullNombre=(sin clasificar)
FiltroTodoNombre=(Todo)
FiltroAncho=30
FiltroTipo=Arbol
FiltroListasRama=GES
FiltroListasAplicaEn=ExplorarGestion.Movimiento
FiltroGrupo2=Gestion.Origen
FiltroValida2=Gestion.Origen
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
ElementosPorPagina=200
IconosSubTitulo=<T>Movimiento<T>
ListaEnCaptura=(Lista)
FiltroArbolClave=ExplorarGestion.Movimiento
FiltroArbolValidar=ExplorarGestion.Movimiento
FiltroArbolRama=ExplorarGestion.Rama
FiltroArbolAcumulativas=ExplorarGestion.EsAcumulativo
OtroOrden=S
ListaOrden=ExplorarGestion.Movimiento<TAB>(Acendente)
FiltroTodo=S
FiltroListas=S
FiltroRespetar=S
FiltroArbolAplica=ExplorarGestion.Rama
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
FiltroEstatus=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSituacion=S
FiltroEmpresas=S
FiltroSucursales=S
FiltroUENs=S
FiltroListaEstatus=(Lista)
FiltroFechasCampo=ExplorarGestion.FechaEmision
FiltroFechasNormal=S
FiltroFechasCancelacion=ExplorarGestion.FechaCancelacion
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaRespetarFiltros=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=30
BusquedaEnLinea=S
FiltroUENsCampo=ExplorarGestion.UEN
FiltroEstatusDefault=(Todos)
FiltroSituacionTodo=S
IconosConSenales=S
IconosNombre=ExplorarGestion2:ExplorarGestion.Movimiento
[Lista.Columnas]
0=111
1=212
2=77
3=91
4=100
5=85
6=284
7=60



8=56
9=-2
10=-2







ID=64
Empresa=45
Mov=124
MovID=124
FechaEmision=94
UltimoCambio=94
Concepto=122
Proyecto=112
Usuario=64
Autorizacion=64
Referencia=82
DocFuente=64
Observaciones=604
Estatus=94
Situacion=304
SituacionFecha=94
SituacionUsuario=83
SituacionNota=604
11=85
12=-2
13=-2
14=-2
15=-2
16=-2
17=-2


Usuario_1=64
Participacion=124







Origen=76
FechaRegistro=94
Duracion=64
Estado=70
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
NombreDesplegar=Imprimir
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Documento Nuevo Usando]
Nombre=Documento Nuevo Usando
Boton=6
NombreDesplegar=Documento Nuevo Usando
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Enviar a Excel]
Nombre=Enviar a Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.INFO]
Nombre=INFO
Boton=34
NombreDesplegar=INFO
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=GestionLista
Activo=S
Visible=S


[Acciones.MovPropiedades]
Nombre=MovPropiedades
Boton=35
NombreEnBoton=S
NombreDesplegar=&Movimiento
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Visible=S

EspacioPrevio=S
ConCondicion=S
EjecucionCondicion=ConDatos(ExplorarGestion2:ExplorarGestion.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>GES<T>)<BR>Asigna(Info.ID, ExplorarGestion2:ExplorarGestion.ID)
[Acciones.Mostrar Campos]
Nombre=Mostrar Campos
Boton=45
NombreDesplegar=&Mostrar Campos
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
EspacioPrevio=S

















[Lista.ExplorarGestion.Estatus]
Carpeta=Lista
Clave=ExplorarGestion.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.ExplorarGestion.UEN]
Carpeta=Lista
Clave=ExplorarGestion.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ExplorarGestion.Sucursal]
Carpeta=Lista
Clave=ExplorarGestion.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Lista.ExplorarGestion.FechaEmision]
Carpeta=Lista
Clave=ExplorarGestion.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ExplorarGestion.Asunto]
Carpeta=Lista
Clave=ExplorarGestion.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.ExplorarGestion.Situacion]
Carpeta=Lista
Clave=ExplorarGestion.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ExplorarGestion.Duracion]
Carpeta=Lista
Clave=ExplorarGestion.Duracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ExplorarGestion.Prioridad]
Carpeta=Lista
Clave=ExplorarGestion.Prioridad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[Lista.ExplorarGestion.Usuario]
Carpeta=Lista
Clave=ExplorarGestion.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco




















































































































































































[Lista.ListaEnCaptura]
(Inicio)=ExplorarGestion.Asunto
ExplorarGestion.Asunto=ExplorarGestion.Estatus
ExplorarGestion.Estatus=ExplorarGestion.FechaEmision
ExplorarGestion.FechaEmision=ExplorarGestion.Situacion
ExplorarGestion.Situacion=ExplorarGestion.Usuario
ExplorarGestion.Usuario=ExplorarGestion.Sucursal
ExplorarGestion.Sucursal=ExplorarGestion.UEN
ExplorarGestion.UEN=ExplorarGestion.Prioridad
ExplorarGestion.Prioridad=ExplorarGestion.Duracion
ExplorarGestion.Duracion=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Documento Nuevo Usando
Documento Nuevo Usando=Enviar a Excel
Enviar a Excel=INFO
INFO=MovPropiedades
MovPropiedades=Mostrar Campos
Mostrar Campos=(Fin)
