[Forma]
Clave=OrganizacionPosicionLista
Icono=6
Modulos=(Todos)
Nombre=e(<T>Posiciones de<T>)+<T> <T>+Info.Nombre

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=308
PosicionInicialArriba=138
PosicionInicialAlturaCliente=456
PosicionInicialAncho=750
ExpresionesAlMostrar=Asigna(Info.Nombre, SQL(<T>SELECT Nombre FROM Organizacion WHERE Organizacion=:nOrganizacion<T>, Empresa.Organizacion))
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Posiciones
Clave=Lista
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OrganizacionPosicion
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Posición<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=OrganizacionPosicion.Nombre

ListaOrden=OrganizacionPosicion.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
IconosNombre=OrganizacionPosicion:OrganizacionPosicion.Posicion
FiltroGeneral=OrganizacionPosicion.Organizacion={Empresa.Organizacion}
[Lista.ListaEnCaptura]
(Inicio)=OrganizacionPosicion.Nombre
OrganizacionPosicion.Nombre=OrganizacionPosicion.Capacidad
OrganizacionPosicion.Capacidad=OrganizacionPosicion.RolEsp
OrganizacionPosicion.RolEsp=(Fin)

[Lista.OrganizacionPosicion.Nombre]
Carpeta=Lista
Clave=OrganizacionPosicion.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



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

[Lista.Columnas]
0=108
1=469
2=-2
3=-2

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
























[Acciones.Entidades]
Nombre=Entidades
Boton=47
NombreEnBoton=S
NombreDesplegar=&Entidades Asignadas
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=OrganizacionPosicionEntidad
Activo=S
ConCondicion=S
Antes=S
Visible=S







EjecucionCondicion=ConDatos(OrganizacionPosicion:OrganizacionPosicion.Posicion)
AntesExpresiones=Asigna(Info.Posicion, OrganizacionPosicion:OrganizacionPosicion.Posicion)<BR>Asigna(Info.Nombre, OrganizacionPosicion:OrganizacionPosicion.Nombre)














[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Entidades
Entidades=Personalizar
Personalizar=(Fin)
