

[Forma]
Clave=VisorEventosIS
Icono=0
Nombre=Visor de Eventos IS (Servicios Intelisis)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
CarpetaPrincipal=Lista
ListaCarpetas=Lista
PosicionInicialIzquierda=268
PosicionInicialArriba=124
PosicionInicialAlturaCliente=441
PosicionInicialAncho=830
PosicionSec1=81
Menus=S
MenuPrincipal=&Archivo
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=Cerrar&
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
EnMenu=S
EspacioPrevio=S
[Acciones.Excel]
Nombre=Excel
Boton=67
NombreEnBoton=S
NombreDesplegar=Excel&
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S



[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Servicios Intelisis
Clave=Lista
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VisorEventosIS
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosConRejilla=S
IconosConPaginas=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

ListaOrden=(Lista)
FiltroPredefinido=S
FiltroGrupo1=VisorEventosIS.EstatusMostrar
FiltroValida1=VisorEventosIS.EstatusMostrar
FiltroGrupo2=VisorEventosIS.FechaFiltro
FiltroValida2=VisorEventosIS.FechaFiltro
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
IconosSubTitulo=Estatus



BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
IconosNombre=<T> <T> + VisorEventosIS:VisorEventosIS.EstatusMostrar
FiltroTodoFinal=S
[Lista.VisorEventosIS.FechaEstatus]
Carpeta=Lista
Clave=VisorEventosIS.FechaEstatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=19
ColorFondo=Blanco

[Lista.VisorEventosIS.Sistema]
Carpeta=Lista
Clave=VisorEventosIS.Sistema
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.VisorEventosIS.Referencia]
Carpeta=Lista
Clave=VisorEventosIS.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.VisorEventosIS.SubReferencia]
Carpeta=Lista
Clave=VisorEventosIS.SubReferencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco




[Lista.Columnas]
0=112
1=53
2=115
3=83
4=174
5=107
6=107
7=-2
8=-2
9=-2

10=-2





















[Detalle.VisorEventosIS.ID]
Carpeta=Detalle
Clave=VisorEventosIS.ID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.VisorEventosIS.SolicitudMax]
Carpeta=Detalle
Clave=VisorEventosIS.SolicitudMax
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=55x10
[Detalle.VisorEventosIS.ResultadoMax]
Carpeta=Detalle
Clave=VisorEventosIS.ResultadoMax
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


Tamano=55x10









































[Detalle.ListaEnCaptura]
(Inicio)=VisorEventosIS.SolicitudMax
VisorEventosIS.SolicitudMax=VisorEventosIS.ResultadoMax
VisorEventosIS.ResultadoMax=VisorEventosIS.ID
VisorEventosIS.ID=(Fin)

[Detalle.ListaOrden]
(Inicio)=VisorEventosIS.ID	(Decendente)
VisorEventosIS.ID	(Decendente)=VisorEventosIS.EstatusMostrar	(Acendente)
VisorEventosIS.EstatusMostrar	(Acendente)=(Fin)



[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)








[Lista.VisorEventosIS.ID]
Carpeta=Lista
Clave=VisorEventosIS.ID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco







[Acciones.Detalle]
Nombre=Detalle
Boton=35
NombreDesplegar=Ver Detalle&
EnBarraHerramientas=S
TipoAccion=Formas
Activo=S
Visible=S


ClaveAccion=VisorEventosISD
Multiple=S



ListaAccionesMultiples=(Lista)

Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
EnMenu=S
[Acciones.Detalle.Asigna]
Nombre=Asigna
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.ID,VisorEventosIS:VisorEventosIS.ID)
Activo=S
Visible=S

[Acciones.Detalle.Forma]
Nombre=Forma
Boton=0
TipoAccion=Formas
ClaveAccion=VisorEventosISD
Activo=S
Visible=S





[Acciones.Descartar]
Nombre=Descartar
Boton=36
NombreDesplegar=Descartar&
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S

















Multiple=S
ListaAccionesMultiples=(Lista)

Menu=&Archivo
EnMenu=S
ActivoCondicion=Si<BR>  VisorEventosIS:VisorEventosIS.Estatus = <T>ERROR<T><BR>Entonces<BR>  verdadero<BR>Sino<BR>  falso<BR>Fin
[Acciones.Descartar.Actualiza]
Nombre=Actualiza
Boton=0
TipoAccion=Expresion
Expresion=EjecutarSQL( <T>EXEC dbo.spDescartarServicio :tID<T>, VisorEventosIS:VisorEventosIS.ID )
Activo=S
Visible=S

[Acciones.Descartar.Refrescar Controles]
Nombre=Refrescar Controles
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S








[Acciones.Actualizar]
Nombre=Actualizar
Boton=52
NombreDesplegar=Actualizar&
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S








Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F5

ConAutoEjecutar=S
AutoEjecutarExpresion=30
[Lista.ListaEnCaptura]
(Inicio)=VisorEventosIS.ID
VisorEventosIS.ID=VisorEventosIS.FechaEstatus
VisorEventosIS.FechaEstatus=VisorEventosIS.Sistema
VisorEventosIS.Sistema=VisorEventosIS.Referencia
VisorEventosIS.Referencia=VisorEventosIS.SubReferencia
VisorEventosIS.SubReferencia=(Fin)

[Lista.ListaOrden]
(Inicio)=VisorEventosIS.ID	(Decendente)
VisorEventosIS.ID	(Decendente)=VisorEventosIS.Estatus	(Acendente)
VisorEventosIS.Estatus	(Acendente)=(Fin)










[Acciones.Descartar.ListaAccionesMultiples]
(Inicio)=Actualiza
Actualiza=Refrescar Controles
Refrescar Controles=(Fin)




[Acciones.Detalle.ListaAccionesMultiples]
(Inicio)=Asigna
Asigna=Forma
Forma=(Fin)















[Forma.ListaAcciones]
(Inicio)=Actualizar
Actualizar=Descartar
Descartar=Detalle
Detalle=Excel
Excel=Cerrar
Cerrar=(Fin)
