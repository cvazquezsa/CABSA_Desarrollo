[Forma]
Clave=EventoSeleccionar
Nombre=Eventos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=142
PosicionInicialArriba=118
PosicionInicialAlturaCliente=451
PosicionInicialAncho=767
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EventoDLista
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Evento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroGrupo1=Evento.ID
FiltroValida1=Evento.Nombre
FiltroGrupo2=EventoD.Giro
FiltroValida2=EventoD.Giro
FiltroGrupo3=EventoD.SubGiro
FiltroValida3=EventoD.SubGiro
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroTodoFinal=S
FiltroAncho=30
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
PestanaOtroNombre=S
IconosNombre=EventoDLista:Evento.Nombre

[Lista.EventoD.Giro]
Carpeta=Lista
Clave=EventoD.Giro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EventoD.SubGiro]
Carpeta=Lista
Clave=EventoD.SubGiro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=180
1=150

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Evento, EventoDLista:Evento.Nombre)<BR>Asigna(Info.Giro, EventoDLista:EventoD.Giro)<BR>Asigna(Info.SubGiro, EventoDLista:EventoD.SubGiro)
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=EventoD.Giro
EventoD.Giro=EventoD.SubGiro
EventoD.SubGiro=(Fin)
