[Forma]
Clave=CteCtoEvento
Nombre=Eventos del Contacto
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Cliente, Info.Nombre)
PosicionInicialIzquierda=242
PosicionInicialArriba=262
PosicionInicialAlturaCliente=465
PosicionInicialAncho=795
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteCtoEvento
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Autom�tica
CampoColorLetras=Gris
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
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroGeneral=CteCtoEvento.Cliente=<T>{Info.Cliente}<T> AND<BR>CteCtoEvento.ID={Info.ID}

[Lista.Evento.Nombre]
Carpeta=Lista
Clave=Evento.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Gris

[Lista.Evento.Fecha]
Carpeta=Lista
Clave=Evento.Fecha
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Lista.EventoD.Giro]
Carpeta=Lista
Clave=EventoD.Giro
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.EventoD.SubGiro]
Carpeta=Lista
Clave=EventoD.SubGiro
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.CteCtoEvento.Espacio]
Carpeta=Lista
Clave=CteCtoEvento.Espacio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
Nombre=217
Fecha=68
Giro=168
SubGiro=181
Espacio=64
EventoD=53
Estatus=63

[Acciones.Asignar]
Nombre=Asignar
Boton=88
NombreEnBoton=S
NombreDesplegar=&Asignar Eventos
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
EspacioPrevio=S
Multiple=S
ListaAccionesMultiples=CteCtoEventoDAsignar<BR>Actualizar Vista

[Acciones.Asignar.CteCtoEventoDAsignar]
Nombre=CteCtoEventoDAsignar
Boton=0
TipoAccion=Formas
ClaveAccion=CteCtoEventoDAsignar
Activo=S
Visible=S

[Acciones.Asignar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Lista.CteCtoEvento.Estatus]
Carpeta=Lista
Clave=CteCtoEvento.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Asignar
Asignar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Evento.Nombre
Evento.Nombre=Evento.Fecha
Evento.Fecha=EventoD.Giro
EventoD.Giro=EventoD.SubGiro
EventoD.SubGiro=CteCtoEvento.Espacio
CteCtoEvento.Espacio=CteCtoEvento.Estatus
CteCtoEvento.Estatus=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)