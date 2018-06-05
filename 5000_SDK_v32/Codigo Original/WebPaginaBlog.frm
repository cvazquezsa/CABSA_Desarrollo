[Forma]
Clave=WebPaginaBlog
Nombre=Blog de la Página
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=524
PosicionInicialArriba=304
PosicionInicialAlturaCliente=511
PosicionInicialAncho=921
ListaAcciones=(Lista)
Comentarios=Lista(Info.Pagina, Info.Nombre)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebPaginaBlog
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Fecha/Hora<T>
ElementosPorPagina=200
ListaEnCaptura=(Lista)
PestanaOtroNombre=S
PestanaNombre=Comentarios
Filtros=S
OtroOrden=S
ListaOrden=WebPaginaBlog.Fecha<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
MenuLocal=S
ListaAcciones=(Lista)

IconosNombre=FechaEnTexto(WebPaginaBlog:WebPaginaBlog.Fecha, <T>dd/mmm/aaaa hh:nn am/pm<T>)
FiltroGeneral=WebPaginaBlog.Pagina=<T>{Info.Pagina}<T>
[Lista.WebPaginaBlog.Comentarios]
Carpeta=Lista
Clave=WebPaginaBlog.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=143
1=615

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

[Lista.WebPaginaBlog.Calificacion]
Carpeta=Lista
Clave=WebPaginaBlog.Calificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a E&xcel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.LocalImprimir]
Nombre=LocalImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.LocalPreliminar]
Nombre=LocalPreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.LocalExcel]
Nombre=LocalExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=0
NombreDesplegar=E&liminar Comentario
RefrescarDespues=S
EnMenu=S
ConfirmarAntes=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
ConCondicion=S

Expresion=EjecutarSQL(<T>spWebPaginaBlogEliminar :tPagina, :nRID<T>, WebPaginaBlog:WebPaginaBlog.Pagina, WebPaginaBlog:WebPaginaBlog.RID)<BR> ActualizarForma
EjecucionCondicion=ConDatos(WebPaginaBlog:WebPaginaBlog.RID)
[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)



[Lista.ListaEnCaptura]
(Inicio)=WebPaginaBlog.Comentarios
WebPaginaBlog.Comentarios=WebPaginaBlog.Calificacion
WebPaginaBlog.Calificacion=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalImprimir
LocalImprimir=LocalPreliminar
LocalPreliminar=LocalExcel
LocalExcel=Eliminar
Eliminar=(Fin)
