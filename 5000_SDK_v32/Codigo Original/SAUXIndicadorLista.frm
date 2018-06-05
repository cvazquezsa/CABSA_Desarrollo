[Forma]
Clave=SAUXIndicadorLista
Nombre=Indicadores
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=442
PosicionInicialArriba=191
PosicionInicialAltura=425
PosicionInicialAncho=715
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S
MovModulo=SAUX
PosicionInicialAlturaCliente=480

[Lista]
Estilo=Hoja
Clave=Lista
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodSAUXIndicadorexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SAUXIndicador
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=25
BusquedaEnLinea=S
CarpetaVisible=S
Filtros=S
FiltroGrupo1=SAUXIndicador.Tipo
FiltroValida1=SAUXIndicador.Tipo
FiltroPredefinido=S
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroTodoFinal=S
FiltroNullNombre=(sin familia)
FiltroRespetar=S
FiltroAncho=25
HojaAjustarColumnas=S
FiltroClase=S
FiltroClaseTodo=S
FiltroFechasNormal=S
MenuLocal=S
ListaAcciones=(Lista)
OtroOrden=S
ListaOrden=SAUXIndicador.Indicador<TAB>(Acendente)
PermiteLocalizar=S
PestanaNombre=SAUXIndicadorículos
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroSituacionTodo=S


FiltroGeneral=SAUXIndicador.Tipo<><T>Estructura<T>

[Lista.Columnas]
Servicio=131
Descripcion1=244

Indicador=124
Descripcion=604
[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreDesplegar=&Seleccionar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Visible=S
Activo=S
NombreEnBoton=S
EnBarraHerramientas=S

[Acciones.Info]
Nombre=Info
Boton=34
NombreEnBoton=S
NombreDesplegar=&Infomación
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SAUXIndicadorInfo
Activo=S
Antes=S

AntesExpresiones=Asigna(Info.Servicio, SAUXIndicador:SAUXIndicador.Servicio)<BR>Asigna(Info.SAUXIndicadorTipo, SAUXIndicador:SAUXIndicador.Tipo)
VisibleCondicion=1=2
[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Actualizar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Todo]
Nombre=Todo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Quitar]
Nombre=Quitar
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S





[Lista.SAUXIndicador.Indicador]
Carpeta=Lista
Clave=SAUXIndicador.Indicador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Lista.ListaEnCaptura]
(Inicio)=SAUXIndicador.Indicador
SAUXIndicador.Indicador=SAUXIndicador.Descripcion
SAUXIndicador.Descripcion=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BAJA
BAJA=(Fin)

[Lista.ListaAcciones]
(Inicio)=Actualizar
Actualizar=Todo
Todo=Quitar
Quitar=(Fin)

[Lista.SAUXIndicador.Descripcion]
Carpeta=Lista
Clave=SAUXIndicador.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco













[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Info
Info=(Fin)
