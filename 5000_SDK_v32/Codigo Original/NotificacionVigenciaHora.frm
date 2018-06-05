
[Forma]
Clave=NotificacionVigenciaHora
Icono=207
Modulos=(Todos)
Nombre=Notificaciones - Vigencia horaria

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialAlturaCliente=305
PosicionInicialAncho=308
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=486
PosicionInicialArriba=202
ListaAcciones=Aceptar
Comentarios=Lista(Info.Notificacion)
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NotificacionVigenciaHora
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PermiteEditar=S
ListaEnCaptura=(Lista)


FiltroGeneral=NotificacionVigenciaHora.Estacion = {EstacionTrabajo} AND NotificacionVigenciaHora.Notificacion ={Comillas(Info.Notificacion)}
[Lista.NotificacionVigenciaHora.HoraD]
Carpeta=Lista
Clave=NotificacionVigenciaHora.HoraD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.NotificacionVigenciaHora.HoraA]
Carpeta=Lista
Clave=NotificacionVigenciaHora.HoraA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.Columnas]
HoraD=135
HoraA=139



[Lista.ListaEnCaptura]
(Inicio)=NotificacionVigenciaHora.HoraD
NotificacionVigenciaHora.HoraD=NotificacionVigenciaHora.HoraA
NotificacionVigenciaHora.HoraA=(Fin)

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
Multiple=S
EnBarraHerramientas=S
Activo=S
Visible=S

ListaAccionesMultiples=(Lista)
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=GuardarCambios<BR>Si SQL(<T>SELECT dbo.fnNotificacionVigenciaHoraInvalida(:nEstacion, :tNotificacion)<T>,EstacionTrabajo,NotificacionVigenciaHora:NotificacionVigenciaHora.Notificacion) = 0 Entonces                       <BR>  Verdadero<BR>SiNo<BR>  Falso<BR>Fin
EjecucionMensaje=<T>Vigencia Inválida<T>
[Acciones.Aceptar.GuardarVigencia]
Nombre=GuardarVigencia
Boton=0
TipoAccion=Expresion
Expresion=EJECUTARSQL(<T>EXEC spNotificacionGuardarVigenciaHora :nEstacion, :tNotificacion<T>,EstacionTrabajo,Info.Notificacion)
Activo=S
Visible=S

[Acciones.Aceptar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S













[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=GuardarVigencia
GuardarVigencia=Cerrar
Cerrar=(Fin)
