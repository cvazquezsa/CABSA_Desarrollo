[Forma]
Clave=ExplorarBPlanGasto
Nombre=<T>Explorar Business Plan de <T> + Modulo.Nombre( Info.Modulo )
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
PosicionInicialAlturaCliente=502
PosicionInicialAncho=966
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialIzquierda=157
PosicionInicialArriba=244
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Empresa, Info.Ejercicio)

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=BPlan
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroGrupo1=BPlan.Clase
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S
FiltroGrupo2=BPlan.SubClase
FiltroTodo=S
FiltroTodoFinal=S
FiltroMonedas=S
FiltroSucursales=S
FiltroUENs=S
FiltroUENsCampo=BPlan.UEN
FiltroMonedasCampo=BPlan.Moneda
PestanaOtroNombre=S
PestanaNombre=Artículos
IconosSubTitulo=<T>Concepto<T>
FiltroNull=S
IconosNombre=BPlan:BPlan.Concepto
FiltroGeneral=BPlan.Empresa = <T>{Empresa}<T> AND<BR>BPlan.Modulo = <T>{Info.Modulo}<T> AND<BR>BPlan.Ejercicio = {Info.Ejercicio}

[Lista.Columnas]
0=199
1=94

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

[Lista.TotalCantidad]
Carpeta=Lista
Clave=TotalCantidad
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TotalImporte]
Carpeta=Lista
Clave=TotalImporte
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.BPlan.CentroCostos]
Carpeta=Lista
Clave=BPlan.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Mostrar Campos
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
EspacioPrevio=S

[Lista.TotalCantidadBase]
Carpeta=Lista
Clave=TotalCantidadBase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.TotalImporteBase]
Carpeta=Lista
Clave=TotalImporteBase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.IncrementoCantidadTotal]
Carpeta=Lista
Clave=IncrementoCantidadTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=0

[Lista.IncrementoTotal]
Carpeta=Lista
Clave=IncrementoTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=0

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

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Enviar/Recibir Excel]
Nombre=Enviar/Recibir Excel
Boton=67
NombreDesplegar=Enviar/Recibir Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Info]
Nombre=Info
Boton=34
NombreEnBoton=S
NombreDesplegar=&Artículo
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Visible=S
EspacioPrevio=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Enviar/Recibir Excel
Enviar/Recibir Excel=Info
Info=Campos
Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=TotalCantidadBase
TotalCantidadBase=TotalCantidad
TotalCantidad=TotalImporteBase
TotalImporteBase=TotalImporte
TotalImporte=BPlan.CentroCostos
BPlan.CentroCostos=IncrementoCantidadTotal
IncrementoCantidadTotal=IncrementoTotal
IncrementoTotal=(Fin)
