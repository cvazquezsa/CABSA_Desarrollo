
[Forma]
Clave=NotificacionClaveModulo
Icono=0
Modulos=(Todos)
Nombre=Clave Notificaci{on - Módulos
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
Comentarios=Lista(Info.NotificacionClave)
PosicionInicialIzquierda=392
PosicionInicialArriba=215
PosicionInicialAlturaCliente=274
PosicionInicialAncho=495
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
Vista=NotificacionClaveModulo
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Modulo.Nombre
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

IconosNombre=NotificacionClaveModulo:NotificacionClaveModulo.Modulo
FiltroGeneral=NotificacionClaveModulo.Clave = {Comillas(Info.NotificacionClave)}
[Lista.Modulo.Nombre]
Carpeta=Lista
Clave=Modulo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
0=90
1=-2

[Acciones.Estatus]
Nombre=Estatus
Boton=12
NombreEnBoton=S
NombreDesplegar=&Estatus
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=NotificacionClaveModuloEstatus
Activo=S
Visible=S





Antes=S










AntesExpresiones=Asigna(Info.Modulo,NotificacionClaveModulo:NotificacionClaveModulo.Modulo)
















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Estatus
Estatus=(Fin)
