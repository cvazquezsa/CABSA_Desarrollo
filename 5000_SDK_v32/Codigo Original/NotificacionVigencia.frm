
[Forma]
Clave=NotificacionVigencia
Icono=729
Modulos=(Todos)
Nombre=Vigencia Notificaciones

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Notificacion)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=483
PosicionInicialArriba=195
PosicionInicialAlturaCliente=319
PosicionInicialAncho=313
VentanaExclusiva=S
VentanaExclusivaOpcion=0
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NotificacionVigencia
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

CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=NotificacionVigencia.Notificacion = {Comillas(Info.Notificacion)} AND NotificacionVigencia.Estacion = {EstacionTrabajo}
FiltroRespetar=S
FiltroTipo=General
[Lista.NotificacionVigencia.FechaD]
Carpeta=Lista
Clave=NotificacionVigencia.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.NotificacionVigencia.FechaA]
Carpeta=Lista
Clave=NotificacionVigencia.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S

ConCondicion=S
EjecucionConError=S
Multiple=S
ListaAccionesMultiples=(Lista)
EjecucionCondicion=GuardarCambios<BR>Si SQL(<T>SELECT dbo.fnNotificacionVigenciaInvalida(:nEstacion, :tNotificacion)<T>,EstacionTrabajo,NotificacionVigencia:NotificacionVigencia.Notificacion) = 0 Entonces<BR>  Verdadero<BR>SiNo<BR>  Falso<BR>Fin
EjecucionMensaje=<T>Vigencia Invalida<T>
[Lista.Columnas]
FechaD=131
FechaA=148



[Acciones.Aceptar.Verificar]
Nombre=Verificar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
ConCondicion=S
EjecucionConError=S
Visible=S



EjecucionCondicion=Si SQL(<T>SELECT dbo.fnNotificacionVigenciaInvalida(:nEstacion, :tNotificacion)<T>,EstacionTrabajo,NotificacionVigencia:NotificacionVigencia.Notificacion) = 0 Entonces<BR>  Verdadero<BR>SiNo<BR>  Falso<BR>Fin
EjecucionMensaje=<T>Vigencia Inválida<T>

[Lista.ListaEnCaptura]
(Inicio)=NotificacionVigencia.FechaD
NotificacionVigencia.FechaD=NotificacionVigencia.FechaA
NotificacionVigencia.FechaA=(Fin)

[Acciones.Aceptar.Guardar]
Nombre=Guardar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Aceptar.GuardarVigencia]
Nombre=GuardarVigencia
Boton=0
TipoAccion=Expresion
Expresion=EJECUTARSQL(<T>EXEC spNotificacionGuardarVigencia :nEstacion, :tNotificacion<T>,EstacionTrabajo,Info.Notificacion)
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
