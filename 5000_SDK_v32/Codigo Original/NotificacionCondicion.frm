
[Forma]
Clave=NotificacionCondicion
Icono=166
Modulos=(Todos)
Nombre=Notificaciones - Condición De Usuario

ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Notificacion)
PosicionInicialAlturaCliente=416
PosicionInicialAncho=724
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=438
PosicionInicialArriba=208
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NotificacionCondicion
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
ListaEnCaptura=NotificacionCondicion.CondicionUsuario
CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=NotificacionCondicion.Notificacion = {Comillas(Info.Notificacion)}
AlinearTodaCarpeta=S
[Ficha.NotificacionCondicion.CondicionUsuario]
Carpeta=Ficha
Clave=NotificacionCondicion.CondicionUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100x25
ColorFondo=Blanco

ConScroll=S
SinRecapitular=S
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
Aceptar=Ayuda
Ayuda=(Fin)
