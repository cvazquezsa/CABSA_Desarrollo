[Forma]
Clave=RepConversacion
Nombre=Conversación
Icono=61
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=275
PosicionInicialArriba=243
PosicionInicialAlturaCliente=503
PosicionInicialAncho=729
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionColumna1=84
PosicionSeccion1=79
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Reporte, Info.Nombre)
IniciarAgregando=S
BarraAcciones=S
VentanaSinIconosMarco=S
VentanaExclusiva=S

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=RepConversacionLista
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=RepConversacion.Mensaje
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Mensajes
OtroOrden=S
ListaOrden=RepConversacion.ID<TAB>(Acendente)
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Contacto<T>
ElementosPorPagina=200
MenuLocal=S
ListaAcciones=Ver
IconosNombre=RepConversacionLista:RepConversacion.Contacto
FiltroGeneral=RepConversacion.Reporte=<T>{Info.Reporte}<T>

[Lista.Columnas]
FechaHora=143
Contacto=174
0=131
1=554

[Ficha.RepConversacion.Mensaje]
Carpeta=Ficha
Clave=RepConversacion.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=89x3
ColorFondo=Blanco
ColorFuente=Negro
ConScroll=N
EditarConBloqueo=N

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
Multiple=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cerrar

[Lista.RepConversacion.Mensaje]
Carpeta=Lista
Clave=RepConversacion.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Ver]
Nombre=Ver
Boton=0
NombreDesplegar=&Ver Mensaje
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=VerComentario(e(<T>Mensaje<T>)+<T> - <T>+RepConversacionLista:RepConversacion.Contacto+<T> [<T>+RepConversacionLista:FechaHoraEnTexto+<T>]<T>, RepConversacionLista:RepConversacion.Mensaje)

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=RepConversacion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S

[Ficha.RepConversacion.FechaHora]
Carpeta=Ficha
Clave=RepConversacion.FechaHora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Enviar.Guardar Cambios]
Nombre=Guardar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Enviar.Registro Agregar]
Nombre=Registro Agregar
Boton=0
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Enviar]
Nombre=Enviar
Boton=0
NombreDesplegar=Enviar
Multiple=S
EnBarraAcciones=S
TipoAccion=Controles Captura
ListaAccionesMultiples=Guardar Cambios<BR>Actualizar Vista<BR>Registro Agregar
Activo=S
Visible=S

[Acciones.Enviar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Cerrar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cerrar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Ir a la Carpeta
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Reporte]
Nombre=Reporte
Boton=68
NombreDesplegar=&Reporte
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=RepConversacion
ListaParametros1=Info.Reporte
ListaParametros=S
Activo=S
Visible=S
EspacioPrevio=S

[Ficha.RepConversacion.Contacto]
Carpeta=Ficha
Clave=RepConversacion.Contacto
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S



[Ficha.ListaEnCaptura]
(Inicio)=RepConversacion.Mensaje
RepConversacion.Mensaje=RepConversacion.FechaHora
RepConversacion.FechaHora=RepConversacion.Contacto
RepConversacion.Contacto=(Fin)



[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Reporte
Reporte=Personalizar
Personalizar=Enviar
Enviar=(Fin)
