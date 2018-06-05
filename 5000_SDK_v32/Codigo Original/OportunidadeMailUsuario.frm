
[Forma]
Clave=OportunidadeMailUsuario
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
Comentarios=Lista(Info.Mov +<T> <T>+Info.MovID)
MovModulo=OPORT
VentanaExclusiva=S
VentanaExclusivaOpcion=2
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OportunidadeMailUsuario
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(por Omisión)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Contacto<T>
ElementosPorPaginaEsp=200
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

BusquedaRapidaControles=S
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
FiltroFechasCampo=OportunidadeMailUsuario.Fecha
FiltroGrupo1=OportunidadeMailUsuario.Estatus
FiltroValida1=OportunidadeMailUsuario.Estatus
FiltroTodoFinal=S
FiltroTodo=S



ListaEnCaptura=(Lista)
FiltroFechasDefault=Hoy
IconosNombre=OportunidadeMailUsuario:OportunidadeMailUsuario.Contacto
FiltroGeneral=OportunidadeMailUsuario.Empresa = {Comillas(Empresa)} AND OportunidadeMailUsuario.ModuloID = {Info.ID}
[Lista.Columnas]
0=67
1=134
2=79
3=103
4=294
5=148
6=198




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






















[Acciones.Mensaje]
Nombre=Mensaje
Boton=84
NombreEnBoton=S
NombreDesplegar=&Mensaje
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=OportunidadeMailUsuarioMensaje
Activo=S
Antes=S
Visible=S









AntesExpresiones=Asigna(Info.ID, OportunidadeMailUsuario:OportunidadeMailUsuario.RID)<BR>Asigna(Info.Nombre, <T>Oportunidades<T>)<BR>Asigna(Info.Mov, OportunidadeMailUsuario:Oportunidad.Mov+<T> <T>+OportunidadeMailUsuario:Oportunidad.MovID)
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

















[Lista.OportunidadeMailUsuario.Asunto]
Carpeta=Lista
Clave=OportunidadeMailUsuario.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.OportunidadeMailUsuario.Mensaje]
Carpeta=Lista
Clave=OportunidadeMailUsuario.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.OportunidadeMailUsuario.Para]
Carpeta=Lista
Clave=OportunidadeMailUsuario.Para
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.OportunidadeMailUsuario.Anexos]
Carpeta=Lista
Clave=OportunidadeMailUsuario.Anexos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

























[Lista.OportunidadeMailUsuario.Fecha]
Carpeta=Lista
Clave=OportunidadeMailUsuario.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Lista.Cte.Nombre]
Carpeta=Lista
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco





[Lista.ListaEnCaptura]
(Inicio)=Cte.Nombre
Cte.Nombre=OportunidadeMailUsuario.Fecha
OportunidadeMailUsuario.Fecha=OportunidadeMailUsuario.Asunto
OportunidadeMailUsuario.Asunto=OportunidadeMailUsuario.Mensaje
OportunidadeMailUsuario.Mensaje=OportunidadeMailUsuario.Para
OportunidadeMailUsuario.Para=OportunidadeMailUsuario.Anexos
OportunidadeMailUsuario.Anexos=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=(Fin)



















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Mensaje
Mensaje=Excel
Excel=VistaPrevia
VistaPrevia=MostrarCampos
MostrarCampos=(Fin)
