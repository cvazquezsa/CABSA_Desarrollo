[Forma]
Clave=OrganizacionPosicion
Icono=0
Modulos=(Todos)
Nombre=e(<T>Posiciones de<T>)+<T> <T>+Info.Nombre

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=374
PosicionInicialArriba=67
PosicionInicialAlturaCliente=598
PosicionInicialAncho=618
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionSec1=424
ExpresionesAlMostrar=Asigna(Info.Nombre, SQL(<T>SELECT Nombre FROM Organizacion WHERE Organizacion=:nOrganizacion<T>, Empresa.Organizacion))
EsConsultaExclusiva=S
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OrganizacionPosicion
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

ListaOrden=OrganizacionPosicion.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

HojaIndicador=S
HojaMantenerSeleccion=S
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
FiltroGeneral=OrganizacionPosicion.Organizacion={Empresa.Organizacion}
[Lista.OrganizacionPosicion.Posicion]
Carpeta=Lista
Clave=OrganizacionPosicion.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



[Lista.OrganizacionPosicion.Nombre]
Carpeta=Lista
Clave=OrganizacionPosicion.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Columnas]
Posicion=124
Nombre=377
CapacidadEsp=104
RolEsp=251

Capacidad=55

PosicionRama=95
[Lista.OrganizacionPosicion.Capacidad]
Carpeta=Lista
Clave=OrganizacionPosicion.Capacidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Entidades.Entidad.Nombre]
Carpeta=Entidades
Clave=Entidad.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Entidades.EntidadPosicion.Rol]
Carpeta=Entidades
Clave=EntidadPosicion.Rol
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



[Entidades.Columnas]
0=98
1=218
2=248


3=154
[Acciones.EntidadPersonalizar]
Nombre=EntidadPersonalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
Carpeta=Entidades
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S









[Acciones.Editar]
Nombre=Editar
Boton=35
NombreEnBoton=S
NombreDesplegar=&Editar Posiciones
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Si<BR>  Forma(<T>OrganizacionPosicionEditar<T>)<BR>Entonces<BR>  Forma.ActualizarForma<BR>Fin
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









[Entidades]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Entidades
Clave=Entidades
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=EntidadPosicion
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=OrganizacionPosicion
LlaveLocal=(Lista)

LlaveMaestra=(Lista)
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Entidad<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S



MenuLocal=S
ListaAcciones=Personalizar
IconosNombre=EntidadPosicion:EntidadPosicion.Entidad
[Entidades.EntidadPosicion.Observaciones]
Carpeta=Entidades
Clave=EntidadPosicion.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[Acciones.Personalizar]
Nombre=Personalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
Carpeta=Entidades
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S




[Lista.ListaEnCaptura]
(Inicio)=OrganizacionPosicion.Posicion
OrganizacionPosicion.Posicion=OrganizacionPosicion.Nombre
OrganizacionPosicion.Nombre=OrganizacionPosicion.Capacidad
OrganizacionPosicion.Capacidad=(Fin)



[Entidades.LlaveLocal]
(Inicio)=EntidadPosicion.Organizacion
EntidadPosicion.Organizacion=EntidadPosicion.Posicion
EntidadPosicion.Posicion=(Fin)

[Entidades.LlaveMaestra]
(Inicio)=OrganizacionPosicion.Organizacion
OrganizacionPosicion.Organizacion=OrganizacionPosicion.Posicion
OrganizacionPosicion.Posicion=(Fin)

[Entidades.ListaEnCaptura]
(Inicio)=EntidadPosicion.Rol
EntidadPosicion.Rol=EntidadPosicion.Observaciones
EntidadPosicion.Observaciones=(Fin)







[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Entidades
Entidades=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Editar
Editar=(Fin)
