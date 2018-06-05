
[Forma]
Clave=NotificacionTagAyuda
Icono=5
Modulos=(Todos)
Nombre=Ayuda Etiquetas Notificación

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialAlturaCliente=436
PosicionInicialAncho=703
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=346
PosicionInicialArriba=110
Comentarios=Info.Notificacion
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NotificacionTagAyuda
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Etiqueta<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

IconosNombre=NotificacionTagAyuda:NotificacionTagAyuda.Tag
[Lista.NotificacionTagAyuda.Asunto]
Carpeta=Lista
Clave=NotificacionTagAyuda.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.NotificacionTagAyuda.Mensaje]
Carpeta=Lista
Clave=NotificacionTagAyuda.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.NotificacionTagAyuda.Consulta]
Carpeta=Lista
Clave=NotificacionTagAyuda.Consulta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.NotificacionTagAyuda.Descripcion]
Carpeta=Lista
Clave=NotificacionTagAyuda.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

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
0=127
1=-2
2=-2
3=-2
4=55
5=-2





[Lista.ListaEnCaptura]
(Inicio)=NotificacionTagAyuda.Asunto
NotificacionTagAyuda.Asunto=NotificacionTagAyuda.Mensaje
NotificacionTagAyuda.Mensaje=NotificacionTagAyuda.Condicion
NotificacionTagAyuda.Condicion=NotificacionTagAyuda.Consulta
NotificacionTagAyuda.Consulta=NotificacionTagAyuda.Descripcion
NotificacionTagAyuda.Descripcion=(Fin)

[Lista.NotificacionTagAyuda.Condicion]
Carpeta=Lista
Clave=NotificacionTagAyuda.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
