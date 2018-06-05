
[Forma]
Clave=NotificacionDestinatario
Icono=243
Modulos=(Todos)
Nombre=Destinatarios Notificación

ListaCarpetas=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=Detalle
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Notificacion)
PosicionInicialIzquierda=336
PosicionInicialArriba=130
PosicionInicialAlturaCliente=449
PosicionInicialAncho=607
PosicionCol1=283
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NotificacionDestinatario
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
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

HojaMantenerSeleccion=S
FiltroGeneral=NotificacionDestinatario.Notificacion = {Comillas(Info.Notificacion)}
[Lista.NotificacionDestinatario.SeccionDestinatario]
Carpeta=Lista
Clave=NotificacionDestinatario.SeccionDestinatario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.NotificacionDestinatario.TipoDestinatario]
Carpeta=Lista
Clave=NotificacionDestinatario.TipoDestinatario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Detalle]
Estilo=Ficha
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=NotificacionDestinatario
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
PestanaOtroNombre=S
PestanaNombre=Detalle

[Detalle.NotificacionDestinatario.Destinatario]
Carpeta=Detalle
Clave=NotificacionDestinatario.Destinatario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Detalle.NotificacionDestinatario.DestinatarioCorreo]
Carpeta=Detalle
Clave=NotificacionDestinatario.DestinatarioCorreo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco


[Lista.Columnas]
SeccionDestinatario=124
TipoDestinatario=124













[Detalle.NotificacionDestinatario.SeccionDestinatario]
Carpeta=Detalle
Clave=NotificacionDestinatario.SeccionDestinatario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Detalle.NotificacionDestinatario.TipoDestinatario]
Carpeta=Detalle
Clave=NotificacionDestinatario.TipoDestinatario
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






[Detalle.ListaEnCaptura]
(Inicio)=NotificacionDestinatario.SeccionDestinatario
NotificacionDestinatario.SeccionDestinatario=NotificacionDestinatario.TipoDestinatario
NotificacionDestinatario.TipoDestinatario=NotificacionDestinatario.Destinatario
NotificacionDestinatario.Destinatario=NotificacionDestinatario.DestinatarioCorreo
NotificacionDestinatario.DestinatarioCorreo=(Fin)










[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S







NombreEnBoton=S
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S











NombreEnBoton=S









ConfirmarAntes=S
[Lista.ListaEnCaptura]
(Inicio)=NotificacionDestinatario.SeccionDestinatario
NotificacionDestinatario.SeccionDestinatario=NotificacionDestinatario.TipoDestinatario
NotificacionDestinatario.TipoDestinatario=(Fin)



[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=(Fin)
