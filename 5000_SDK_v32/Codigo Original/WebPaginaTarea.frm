[Forma]
Clave=WebPaginaTarea
Nombre=Tareas de la Página
Icono=62
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=517
PosicionInicialArriba=362
PosicionInicialAlturaCliente=439
PosicionInicialAncho=886
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Pagina, Info.Nombre)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebPaginaTarea
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)
PestanaOtroNombre=S
PestanaNombre=Tareas
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Asunto<T>
ElementosPorPagina=200
Filtros=S
IconosNombre=WebPaginaTarea:WebPaginaTarea.Asunto
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=WebPaginaTarea.Pagina=<T>{Info.Pagina}<T>
FiltroRespetar=S
FiltroTipo=General

[Lista.WebPaginaTarea.Comienzo]
Carpeta=Lista
Clave=WebPaginaTarea.Comienzo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.WebPaginaTarea.Fin]
Carpeta=Lista
Clave=WebPaginaTarea.Fin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.WebPaginaTarea.Estado]
Carpeta=Lista
Clave=WebPaginaTarea.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.WebPaginaTarea.Prioridad]
Carpeta=Lista
Clave=WebPaginaTarea.Prioridad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.WebPaginaTarea.Avance]
Carpeta=Lista
Clave=WebPaginaTarea.Avance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.WebPaginaTarea.Responsable]
Carpeta=Lista
Clave=WebPaginaTarea.Responsable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Asunto=41
Comienzo=94
Fin=94
Estado=184
Prioridad=124
Avance=64
Responsable=81
0=319
1=67

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

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=&Preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=E&xcel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Comentarios]
Nombre=Comentarios
Boton=35
NombreEnBoton=S
NombreDesplegar=&Comentarios
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=WebPaginaTareaComentarios
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(WebPaginaTarea:WebPaginaTarea.RID)
Antes=S
AntesExpresiones=Asigna(Info.ID, WebPaginaTarea:WebPaginaTarea.RID)<BR>Asigna(Info.Asunto, WebPaginaTarea:WebPaginaTarea.Asunto)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=Comentarios
Comentarios=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=WebPaginaTarea.Comienzo
WebPaginaTarea.Comienzo=WebPaginaTarea.Fin
WebPaginaTarea.Fin=WebPaginaTarea.Estado
WebPaginaTarea.Estado=WebPaginaTarea.Prioridad
WebPaginaTarea.Prioridad=WebPaginaTarea.Avance
WebPaginaTarea.Avance=WebPaginaTarea.Responsable
WebPaginaTarea.Responsable=(Fin)
