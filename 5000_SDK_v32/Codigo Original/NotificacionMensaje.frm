
[Forma]
Clave=NotificacionMensaje
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Mensaje Notificación
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Mensaje
CarpetaPrincipal=Mensaje
PosicionInicialAlturaCliente=484
PosicionInicialAncho=723
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=438
PosicionInicialArriba=174
Comentarios=Lista(Info.Notificacion)
ListaAcciones=(Lista)
[Mensaje]
Estilo=Ficha
Clave=Mensaje
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NotificacionMensaje
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
ListaEnCaptura=NotificacionMensaje.Mensaje
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=NotificacionMensaje.Notificacion = {Comillas(Info.Notificacion)}
AlinearTodaCarpeta=S
[Mensaje.NotificacionMensaje.Mensaje]
Carpeta=Mensaje
Clave=NotificacionMensaje.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=100x30

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S








[Acciones.Ayuda]
Nombre=Ayuda
Boton=101
NombreEnBoton=S
NombreDesplegar=&Ayuda Etiquetas
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=NotificacionTagAyuda
Activo=S
Visible=S





















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Ayuda
Ayuda=(Fin)
