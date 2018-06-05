
[Forma]
Clave=NotificacionAnexo
Icono=312
Modulos=(Todos)
Nombre=Anexos Notificación

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
PosicionInicialIzquierda=234
PosicionInicialArriba=130
PosicionInicialAlturaCliente=430
PosicionInicialAncho=897
PosicionCol1=478
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NotificacionAnexo
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


FiltroGeneral=NotificacionAnexo.Notificacion = {Comillas(Info.Notificacion)}
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
Vista=NotificacionAnexo
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



[Lista.Columnas]
SeccionDestinatario=124
TipoDestinatario=124















Tipo=133
Ruta=141
Nombre=160
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




[Lista.NotificacionAnexo.Tipo]
Carpeta=Lista
Clave=NotificacionAnexo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.NotificacionAnexo.Ruta]
Carpeta=Lista
Clave=NotificacionAnexo.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.NotificacionAnexo.Nombre]
Carpeta=Lista
Clave=NotificacionAnexo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco


[Detalle.NotificacionAnexo.Tipo]
Carpeta=Detalle
Clave=NotificacionAnexo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.NotificacionAnexo.Ruta]
Carpeta=Detalle
Clave=NotificacionAnexo.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.NotificacionAnexo.Nombre]
Carpeta=Detalle
Clave=NotificacionAnexo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



[Lista.ListaEnCaptura]
(Inicio)=NotificacionAnexo.Tipo
NotificacionAnexo.Tipo=NotificacionAnexo.Ruta
NotificacionAnexo.Ruta=NotificacionAnexo.Nombre
NotificacionAnexo.Nombre=(Fin)









[Detalle.ListaEnCaptura]
(Inicio)=NotificacionAnexo.Tipo
NotificacionAnexo.Tipo=NotificacionAnexo.Ruta
NotificacionAnexo.Ruta=NotificacionAnexo.Nombre
NotificacionAnexo.Nombre=(Fin)



















































































[Acciones.NotificacionTagAyuda]
Nombre=NotificacionTagAyuda
Boton=101
NombreDesplegar=&Ayuda Etiquetas
EnBarraHerramientas=S
TipoAccion=Formas
Activo=S
Visible=S



NombreEnBoton=S
EspacioPrevio=S
ClaveAccion=NotificacionTagAyuda




















[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=NotificacionTagAyuda
NotificacionTagAyuda=(Fin)
