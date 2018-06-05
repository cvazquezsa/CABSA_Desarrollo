[Forma]
Clave=WebPaginaCalendario
Nombre=Calendario de la Página
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=466
PosicionInicialArriba=340
PosicionInicialAlturaCliente=484
PosicionInicialAncho=988
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Pagina, Info.Nombre)
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionCol1=596

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebPaginaCalendario
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
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=WebPaginaCalendario.Ubicacion
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S
HojaAjustarColumnas=S
HojaMantenerSeleccion=S
FiltroGeneral=WebPaginaCalendario.Pagina=<T>{Info.Pagina}<T>

[Lista.WebPaginaCalendario.Asunto]
Carpeta=Lista
Clave=WebPaginaCalendario.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.WebPaginaCalendario.Comienzo]
Carpeta=Lista
Clave=WebPaginaCalendario.Comienzo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.WebPaginaCalendario.Fin]
Carpeta=Lista
Clave=WebPaginaCalendario.Fin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Asunto=288
Comienzo=137
Fin=138
Ubicacion=177
TodoElDia=64

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

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=WebPaginaCalendario
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

[Ficha.WebPaginaCalendario.Asunto]
Carpeta=Ficha
Clave=WebPaginaCalendario.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebPaginaCalendario.Ubicacion]
Carpeta=Ficha
Clave=WebPaginaCalendario.Ubicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebPaginaCalendario.Comienzo]
Carpeta=Ficha
Clave=WebPaginaCalendario.Comienzo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebPaginaCalendario.Fin]
Carpeta=Ficha
Clave=WebPaginaCalendario.Fin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebPaginaCalendario.TodoElDia]
Carpeta=Ficha
Clave=WebPaginaCalendario.TodoElDia
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.WebPaginaCalendario.URL]
Carpeta=Ficha
Clave=WebPaginaCalendario.URL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Agregar]
Nombre=Agregar
Boton=1
NombreEnBoton=S
NombreDesplegar=&Agregar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.Comentarios]
Nombre=Comentarios
Boton=35
NombreEnBoton=S
NombreDesplegar=&Comentarios
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(WebPaginaCalendario:WebPaginaCalendario.Comentarios, EditorHTML.Directo(<T>Comentarios<T>, WebPaginaCalendario:WebPaginaCalendario.Comentarios))

[Acciones.TipoEvento]
Nombre=TipoEvento
Boton=91
NombreEnBoton=S
NombreDesplegar=&Tipos Eventos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=WebPaginaTipoEvento
Activo=S
Visible=S

[Ficha.WebPaginaCalendario.TipoEvento]
Carpeta=Ficha
Clave=WebPaginaCalendario.TipoEvento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Agregar
Agregar=Eliminar
Eliminar=Comentarios
Comentarios=TipoEvento
TipoEvento=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=WebPaginaCalendario.Asunto
WebPaginaCalendario.Asunto=WebPaginaCalendario.Comienzo
WebPaginaCalendario.Comienzo=WebPaginaCalendario.Fin
WebPaginaCalendario.Fin=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=WebPaginaCalendario.Asunto
WebPaginaCalendario.Asunto=WebPaginaCalendario.Ubicacion
WebPaginaCalendario.Ubicacion=WebPaginaCalendario.Comienzo
WebPaginaCalendario.Comienzo=WebPaginaCalendario.Fin
WebPaginaCalendario.Fin=WebPaginaCalendario.TodoElDia
WebPaginaCalendario.TodoElDia=WebPaginaCalendario.URL
WebPaginaCalendario.URL=WebPaginaCalendario.TipoEvento
WebPaginaCalendario.TipoEvento=(Fin)
