[Forma]
Clave=SoporteLista
Nombre=Info.STNombre
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=511
PosicionInicialArriba=374
PosicionInicialAltura=300
PosicionInicialAncho=898
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
PosicionInicialAlturaCliente=416
VentanaEstadoInicial=Normal
EsMovimiento=S
MovModulo=ST
TituloAuto=S
MovEspecificos=Todos
ListaAcciones=Seleccionar

[Acciones.AbrirPropiedades]
Nombre=AbrirPropiedades
Boton=0
NombreDesplegar=P&ropiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(SoporteA:Soporte.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.ID, SoporteA:Soporte.ID)
Visible=S

[Acciones.AbrirImprimir]
Nombre=AbrirImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Visible=S
ActivoCondicion=Usuario.ImprimirMovs

[Acciones.AbrirPreliminar]
Nombre=AbrirPreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Visible=S
ActivoCondicion=Usuario.PreliminarMovs

[Acciones.AbrirExcel]
Nombre=AbrirExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Visible=S
ActivoCondicion=Usuario.EnviarExcel

[Acciones.AbrirCampos]
Nombre=AbrirCampos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.AbrirLocalizar]
Nombre=AbrirLocalizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=Alt+F3
NombreDesplegar=&Localizar
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S

[Acciones.AbrirLocalizarSiguiente]
Nombre=AbrirLocalizarSiguiente
Boton=0
UsaTeclaRapida=S
TeclaRapida=F3
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S

[(Carpeta Abrir).]
Carpeta=(Carpeta Abrir)
ColorFondo=Negro

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=movimientos
Clave=Lista
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S
MenuLocal=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=SoporteA
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(Situación)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
IconosConPaginas=S
ElementosPorPagina=200
IconosCambiarOrden=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=Soporte.ID<TAB>(Decendente)
FiltroAplicaEn=Soporte.Clase
FiltroPredefinido=S
FiltroAutoCampo=Soporte.Clase
FiltroGrupo1=Soporte.Clase
FiltroGrupo2=Soporte.Subclase
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=15
FiltroEstilo=Directorio
FiltroRespetar=S
FiltroTipo=Automático
FiltroEstatus=S
FiltroUsuarios=S
FiltroFechas=S
FiltroMovsTodos=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSituacion=S
FiltroSituacionTodo=S
FiltroProyectos=S
FiltroSucursales=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
FiltroUsuarioDefault=(Usuario)
FiltroFechasCampo=Soporte.FechaEmision
FiltroFechasDefault=(Todo)
FiltroMovDefault=(Todos)
FiltroFechasNormal=S
FiltroFechasCancelacion=Soporte.FechaCancelacion
BusquedaRapida=S
BusquedaRespetarFiltros=S
BusquedaInicializar=S
BusquedaRespetarUsuario=S
BusquedaAncho=20
BusquedaEnLinea=S
BusquedaRespetarControlesNum=S
ListaAcciones=(Lista)
CarpetaVisible=S
IconosNombre=SoporteA:Soporte.Mov+<T> <T>+SoporteA:Soporte.MovID
FiltroGeneral={Si(SQL(<T>SELECT ISNULL(Filtrar, 0) FROM SubModulo WHERE Modulo=:tModulo AND SubModulo=:tSub<T>, <T>ST<T>, Info.SubModuloST), <T>Soporte.SubModulo=<T>+Comillas(Info.SubModuloST), <T>1=1<T>)}<BR>{Si(ConDatos(Filtro.Mov), <T> AND Soporte.Mov=<T>+Comillas(Filtro.Mov), <T><T>)}<BR>{Si(ConDatos(Filtro.Cliente), <T> AND Soporte.Cliente=<T>+Comillas(Filtro.Cliente), <T><T>)}

[Lista.Soporte.Titulo]
Carpeta=Lista
Clave=Soporte.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Soporte.FechaEmision]
Carpeta=Lista
Clave=Soporte.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.]
Carpeta=Lista
ColorFondo=Negro

[Lista.Soporte.Cliente]
Carpeta=Lista
Clave=Soporte.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=109
1=106

[Lista.ListaEnCaptura]
(Inicio)=Soporte.Titulo
Soporte.Titulo=Soporte.FechaEmision
Soporte.FechaEmision=Soporte.FechaConclusion
Soporte.FechaConclusion=Soporte.Vencimiento
Soporte.Vencimiento=Dias
Dias=Atraso
Atraso=Soporte.Estado
Soporte.Estado=Soporte.Cliente
Soporte.Cliente=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=PENDIENTE
PENDIENTE=SINCRO
SINCRO=ALTAPRIORIDAD
ALTAPRIORIDAD=PRIORIDADBAJA
PRIORIDADBAJA=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[Lista.ListaAcciones]
(Inicio)=AbrirPropiedades
AbrirPropiedades=AbrirLocalizar
AbrirLocalizar=AbrirLocalizarSiguiente
AbrirLocalizarSiguiente=Ordenar
Ordenar=AbrirImprimir
AbrirImprimir=AbrirPreliminar
AbrirPreliminar=AbrirExcel
AbrirExcel=AbrirCampos
AbrirCampos=(Fin)
