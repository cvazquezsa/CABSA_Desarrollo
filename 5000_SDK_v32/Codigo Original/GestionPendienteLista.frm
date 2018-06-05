
[Forma]
Clave=GestionPendienteLista
Icono=0
Modulos=(Todos)
BarraHerramientas=S
Nombre=Pendientes
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaEstadoInicial=Normal

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=419
PosicionInicialAncho=500
PosicionInicialIzquierda=390
PosicionInicialArriba=177
ListaAcciones=(Lista)
Comentarios=Info.Mov
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Movimientos
Filtros=S
BusquedaRapidaControles=S
Vista=GestionA
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
IconosSubTitulo=<T>Movimiento<T>
ListaEnCaptura=(Lista)

IconosNombre=GestionA:Gestion.Mov+<T> <T>+GestionA:Gestion.MovID

FiltroGeneral=Gestion.Empresa=<T>{Empresa}<T> AND Gestion.Estatus=<T>PENDIENTE<T>
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaEnLinea=S
[Lista.Gestion.FechaEmision]
Carpeta=Lista
Clave=Gestion.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Gestion.Proyecto]
Carpeta=Lista
Clave=Gestion.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Gestion.Referencia]
Carpeta=Lista
Clave=Gestion.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=-2
1=-2
2=-2
3=-2

[Lista.ListaEnCaptura]
(Inicio)=Gestion.FechaEmision
Gestion.FechaEmision=Gestion.Proyecto
Gestion.Proyecto=Gestion.Referencia
Gestion.Referencia=(Fin)

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(GestionA:Gestion.MovID)
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











[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Personalizar
Personalizar=(Fin)
