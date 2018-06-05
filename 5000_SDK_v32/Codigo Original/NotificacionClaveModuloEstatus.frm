
[Forma]
Clave=NotificacionClaveModuloEstatus
Icono=0
Modulos=(Todos)
Nombre=Notificaciones - Estatus Modulos

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaAcciones=Cerrar
Comentarios=Lista(Info.NotificacionClave,Info.Modulo)
PosicionInicialIzquierda=390
PosicionInicialArriba=216
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NotificacionClaveModuloEstatus
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

IconosSubTitulo=<T>Estatus<T>
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=NotificacionClaveModuloEstatus:NotificacionClaveModuloEstatus.Estatus
FiltroGeneral=NotificacionClaveModuloEstatus.Clave = {Comillas(Info.NotificacionClave)} AND NotificacionClaveModuloEstatus.Modulo = {Comillas(Info.Modulo)}
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

[Lista.Columnas]
0=-2
