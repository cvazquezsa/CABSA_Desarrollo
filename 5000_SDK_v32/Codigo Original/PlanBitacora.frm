[Forma]
Clave=PlanBitacora
Nombre=Bitácora del Planeador
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=251
PosicionInicialArriba=269
PosicionInicialAlturaCliente=451
PosicionInicialAncho=777
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PlanBitacora
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>ID<T>
IconosNombreNumerico=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Corridas
OtroOrden=S
ListaOrden=PlanBitacora.ID<TAB>(Acendente)
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=PlanBitacora.FechaInicio
FiltroFechasDefault=Este Mes
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
IconosNombre=PlanBitacora:PlanBitacora.ID
FiltroGeneral=PlanBitacora.Empresa=<T>{Empresa}<T>

[Lista.Columnas]
0=69
1=327

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
NombreEnBoton=S

[Lista.PlanBitacora.Mensaje]
Carpeta=Lista
Clave=PlanBitacora.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Inicio]
Carpeta=Lista
Clave=Inicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Final]
Carpeta=Lista
Clave=Final
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Tiempo]
Carpeta=Lista
Clave=Tiempo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Mensajes]
Nombre=Mensajes
Boton=47
NombreEnBoton=S
NombreDesplegar=&Mensajes
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PlanMensaje
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.ID, PlanBitacora:PlanBitacora.ID)
Visible=S


[Lista.ListaEnCaptura]
(Inicio)=PlanBitacora.Mensaje
PlanBitacora.Mensaje=Inicio
Inicio=Final
Final=Tiempo
Tiempo=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Mensajes
Mensajes=Personalizar
Personalizar=(Fin)
