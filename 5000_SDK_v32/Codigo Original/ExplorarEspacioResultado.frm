[Forma]
Clave=ExplorarEspacioResultado
Nombre=Explorando - Resultados
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=103
PosicionInicialArriba=88
PosicionInicialAlturaCliente=557
PosicionInicialAncho=818
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EspacioResultado
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Espacio<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
BusquedaRapidaControles=S
FiltroPeriodos=S
FiltroEjercicios=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroEditarFueraPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroAplicaEn=EspacioResultado.Espacio
FiltroGrupo1=EspacioResultado.Espacio
FiltroValida1=EspacioResultado.Espacio
FiltroTodoFinal=S
FiltroGrupo2=EspacioResultado.Parte
FiltroValida2=EspacioResultado.Parte
OtroOrden=S
ListaOrden=(Lista)
BusquedaRapida=S
BusquedaRespetarFiltros=S
BusquedaRespetarControles=S
BusquedaEnLinea=S
BusquedaAncho=20
FiltroTodo=S
IconosNombre=EspacioResultado:EspacioResultado.Espacio
FiltroGeneral=EspacioResultado.Empresa=<T>{Empresa}<T>

[Lista.EspacioResultado.Concepto]
Carpeta=Lista
Clave=EspacioResultado.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EspacioResultado.Ingreso]
Carpeta=Lista
Clave=EspacioResultado.Ingreso
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EspacioResultado.Egreso]
Carpeta=Lista
Clave=EspacioResultado.Egreso
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=59
1=66

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

[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreDesplegar=Actualizar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
EspacioPrevio=S

[Lista.EspacioResultado.Importe]
Carpeta=Lista
Clave=EspacioResultado.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EspacioResultado.Parte]
Carpeta=Lista
Clave=EspacioResultado.Parte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Actualizar
Actualizar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=EspacioResultado.Parte
EspacioResultado.Parte=EspacioResultado.Concepto
EspacioResultado.Concepto=EspacioResultado.Ingreso
EspacioResultado.Ingreso=EspacioResultado.Egreso
EspacioResultado.Egreso=EspacioResultado.Importe
EspacioResultado.Importe=(Fin)

[Lista.ListaOrden]
(Inicio)=EspacioResultado.Espacio<TAB>(Acendente)
EspacioResultado.Espacio<TAB>(Acendente)=EspacioResultado.Parte<TAB>(Acendente)
EspacioResultado.Parte<TAB>(Acendente)=EspacioResultado.Orden<TAB>(Acendente)
EspacioResultado.Orden<TAB>(Acendente)=(Fin)
