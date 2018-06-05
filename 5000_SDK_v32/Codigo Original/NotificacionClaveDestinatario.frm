
[Forma]
Clave=NotificacionClaveDestinatario
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Claves de Notificación - Destinatarios
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Cerrar
Comentarios=Lista(Info.NotificacionClave)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialAlturaCliente=459
PosicionInicialAncho=607
PosicionCol1=283
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=350
PosicionInicialArriba=126
VentanaExclusiva=S
VentanaExclusivaOpcion=3
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

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NotificacionClaveDestinatario
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroGeneral=Clave = {Comillas(Info.NotificacionClave)}
[Lista.NotificacionClaveDestinatario.SeccionDestinatario]
Carpeta=Lista
Clave=NotificacionClaveDestinatario.SeccionDestinatario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle]
Estilo=Ficha
Pestana=S
Clave=Detalle
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=NotificacionClaveDestinatario
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PestanaOtroNombre=S
PestanaNombre=Detalle
FiltroGeneral=Clave = {Comillas(Info.NotificacionClave)}
[Detalle.NotificacionClaveDestinatario.Destinatario]
Carpeta=Detalle
Clave=NotificacionClaveDestinatario.Destinatario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Detalle.NotificacionClaveDestinatario.DestinatarioCorreo]
Carpeta=Detalle
Clave=NotificacionClaveDestinatario.DestinatarioCorreo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco


[Lista.Columnas]
0=-2
1=-2




TipoDestinatario=124
SeccionDestinatario=124

[Lista.NotificacionClaveDestinatario.TipoDestinatario]
Carpeta=Lista
Clave=NotificacionClaveDestinatario.TipoDestinatario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco











[Lista.ListaEnCaptura]
(Inicio)=NotificacionClaveDestinatario.TipoDestinatario
NotificacionClaveDestinatario.TipoDestinatario=NotificacionClaveDestinatario.SeccionDestinatario
NotificacionClaveDestinatario.SeccionDestinatario=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=NotificacionClaveDestinatario.Destinatario
NotificacionClaveDestinatario.Destinatario=NotificacionClaveDestinatario.DestinatarioCorreo
NotificacionClaveDestinatario.DestinatarioCorreo=(Fin)





[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)
