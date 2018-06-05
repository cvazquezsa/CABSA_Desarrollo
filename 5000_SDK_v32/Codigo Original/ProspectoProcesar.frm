[Forma]
Clave=ProspectoProcesar
Nombre=Prospectos
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=592
PosicionInicialArriba=317
PosicionInicialAltura=477
PosicionInicialAncho=736
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S
MovModulo=CRM
PosicionInicialAlturaProspecto=709
ExpresionesAlMostrar=Asigna(Info.Articulo, Nulo)
PosicionInicialAlturaCliente=529

[Lista]
Estilo=Iconos
Clave=Lista
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProspectoProcesar
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S
Filtros=S
FiltroGrupo1=Prospecto.Tipo
FiltroValida1=Prospecto.Tipo
FiltroPredefinido=S
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroTodoFinal=S
FiltroNullNombre=(sin categoría)
FiltroRespetar=S
FiltroAncho=20
FiltroFechasNormal=S
FiltroListasRama=
FiltroListasAplicaEn=
FiltroGrupo2=SIC.Industria
FiltroValida2=SIC.Industria
FiltroGrupo3=SIC.Giro
FiltroValida3=SIC.Giro
PermiteLocalizar=S
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroSituacionTodo=S
OtroOrden=S
ListaOrden=Prospecto.Prospecto<TAB>(Acendente)
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Prospecto<T>
ElementosPorPagina=200
IconosSeleccionMultiple=S
MenuLocal=S
ListaAcciones=(Lista)
PestanaOtroNombre=S
PestanaNombre=Prospectos
ListaEnCaptura=(Lista)
IconosNombre=ProspectoProcesar:Prospecto.Prospecto
FiltroGeneral=ListaFiltro.Estacion={EstacionTrabajo}

[Lista.Columnas]
Prospecto=117
Nombre=293
0=79
1=233
RFC=107

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Todo]
Nombre=Todo
Boton=55
NombreDesplegar=Seleccionar &Todo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S
EspacioPrevio=S

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

[Acciones.LocalTodo]
Nombre=LocalTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.LocalQuitar]
Nombre=LocalQuitar
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.Procesar]
Nombre=Procesar
Boton=25
NombreEnBoton=S
NombreDesplegar=&Procesar Selección
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Antes=S
Visible=S
AntesExpresiones=RegistrarSeleccion(<T>Lista<T>)

[Acciones.Cuantos]
Nombre=Cuantos
Boton=101
NombreDesplegar=Selección Actual
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Informacion(e(<T>Selección Actual: <T>) +ListaConteo(ListaSeleccion(<T>Lista<T>)))

[Lista.Prospecto.Nombre]
Carpeta=Lista
Clave=Prospecto.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Prospecto.Tipo]
Carpeta=Lista
Clave=Prospecto.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Sugerir]
Nombre=Sugerir
Boton=20
NombreDesplegar=&Sugerir
RefrescarDespues=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
NombreEnBoton=S
EspacioPrevio=S
Expresion=Si<BR>  Forma(<T>ProspectoFiltro<T>)<BR>Entonces<BR>  EjecutarSQL(<T>spProspectoFiltro :nEstacion, :tEmpresa<T>, EstacionTrabajo, Empresa)<BR>  Forma.ActualizarVista(<T>Lista<T>) <BR>Fin

[Forma.ListaAcciones]
(Inicio)=Cancelar
Cancelar=Sugerir
Sugerir=Todo
Todo=Cuantos
Cuantos=Procesar
Procesar=Personalizar
Personalizar=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Prospecto.Nombre
Prospecto.Nombre=Prospecto.Tipo
Prospecto.Tipo=(Fin)
