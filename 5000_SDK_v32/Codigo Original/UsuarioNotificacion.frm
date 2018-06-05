
[Forma]
Clave=UsuarioNotificacion
Icono=240
BarraHerramientas=S
Modulos=(Todos)
Nombre=Notificaciones Usuario
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=439
PosicionInicialAncho=881
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=242
PosicionInicialArriba=125
ListaAcciones=(Lista)
Comentarios=Lista(Usuario)
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=UsuarioNotificacion
Fuente={Tahoma, 8, Negro, []}
IconosCampo=Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Fecha<T>
ElementosPorPaginaEsp=200
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

IconosSeleccionMultiple=S
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroFechas=S
FiltroFechasCampo=UsuarioNotificacion.FechaNotificacion
FiltroGrupo1=UsuarioNotificacion.Estatus
FiltroValida1=UsuarioNotificacion.Estatus
FiltroTodoFinal=S
FiltroTodo=S
IconosNombre=UsuarioNotificacion:UsuarioNotificacion.FechaNotificacion
FiltroGeneral=UsuarioNotificacion.Usuario = {Comillas(Usuario)} AND UsuarioNotificacion.Empresa = {Comillas(Empresa)}
[Lista.UsuarioNotificacion.Notificacion]
Carpeta=Lista
Clave=UsuarioNotificacion.Notificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



[Lista.UsuarioNotificacion.Asunto]
Carpeta=Lista
Clave=UsuarioNotificacion.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.UsuarioNotificacion.Para]
Carpeta=Lista
Clave=UsuarioNotificacion.Para
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.Columnas]
0=-2
1=132
2=86
3=94
4=-2
5=209
6=926




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




















[Lista.Modulo.Nombre]
Carpeta=Lista
Clave=Modulo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Movimiento]
Carpeta=Lista
Clave=Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.Mensaje]
Nombre=Mensaje
Boton=84
NombreEnBoton=S
NombreDesplegar=&Mensaje
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=UsuarioNotificacionMensaje
Activo=S
Antes=S
Visible=S






AntesExpresiones=Asigna(Info.ID,UsuarioNotificacion:UsuarioNotificacion.RID)<BR>Asigna(Info.Nombre,UsuarioNotificacion:Modulo.Nombre)<BR>Asigna(Info.Mov,UsuarioNotificacion:Movimiento)

[Acciones.Concluir]
Nombre=Concluir
Boton=7
NombreEnBoton=S
NombreDesplegar=&Marcar como &leído
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
Visible=S




AntesExpresiones=RegistrarSeleccionID( <T>Lista<T> )<BR>EjecutarSQL(<T>spNotificacionCambiarEstatus :nEstacion, :tEstatus<T>, EstacionTrabajo, <T>CONCLUIDO<T>)
[Acciones.Revivir]
Nombre=Revivir
Boton=40
NombreEnBoton=S
NombreDesplegar=Marcar como &no leído
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
Visible=S





















AntesExpresiones=RegistrarSeleccionID( <T>Lista<T> )<BR>EjecutarSQL(<T>spNotificacionCambiarEstatus :nEstacion, :tEstatus<T>, EstacionTrabajo, <T>PENDIENTE<T>)
[Acciones.MostrarCampos]
Nombre=MostrarCampos
Boton=45
NombreDesplegar=&Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S






[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=90
NombreEnBoton=S
NombreDesplegar=Seleccionar Todo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S










[Acciones.Excel]
Nombre=Excel
Boton=115
NombreDesplegar=&Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S


[Acciones.VistaPrevia]
Nombre=VistaPrevia
Boton=6
NombreDesplegar=&Vista previa
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S
















[Acciones.Borrar]
Nombre=Borrar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Borrar Notificaciones
EnBarraHerramientas=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
Visible=S





EspacioPrevio=S
AntesExpresiones=RegistrarSeleccionID( <T>Lista<T> )<BR>EjecutarSQL(<T>spNotificacionBorrar :nEstacion<T>, EstacionTrabajo)









[Lista.ListaEnCaptura]
(Inicio)=UsuarioNotificacion.Notificacion
UsuarioNotificacion.Notificacion=Modulo.Nombre
Modulo.Nombre=Movimiento
Movimiento=UsuarioNotificacion.Asunto
UsuarioNotificacion.Asunto=UsuarioNotificacion.Para
UsuarioNotificacion.Para=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=(Fin)





















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Mensaje
Mensaje=Seleccionar Todo
Seleccionar Todo=Concluir
Concluir=Revivir
Revivir=Borrar
Borrar=Excel
Excel=VistaPrevia
VistaPrevia=MostrarCampos
MostrarCampos=(Fin)
