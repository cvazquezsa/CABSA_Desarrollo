
[Forma]
Clave=IntelisisFactory
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
Vista=IntelisisFactory
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
FiltroGrupo1=IntelisisFactory.EstatusMostrar
FiltroValida1=IntelisisFactory.EstatusMostrar
FiltroGrupo2=IntelisisFactory.FechaFiltro
FiltroValida2=IntelisisFactory.FechaFiltro
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
IconosSubTitulo=<T>Estatus<T>



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
IconosNombre=<T> <T> + IntelisisFactory:IntelisisFactory.EstatusMostrar
FiltroTodoFinal=S
[Lista.IntelisisFactory.FechaEstatus]
Carpeta=Lista
Clave=IntelisisFactory.FechaEstatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=19
ColorFondo=Blanco

[Lista.IntelisisFactory.Sistema]
Carpeta=Lista
Clave=IntelisisFactory.Sistema
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.IntelisisFactory.Referencia]
Carpeta=Lista
Clave=IntelisisFactory.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.IntelisisFactory.SubReferencia]
Carpeta=Lista
Clave=IntelisisFactory.SubReferencia
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





















[Detalle.IntelisisFactory.ID]
Carpeta=Detalle
Clave=IntelisisFactory.ID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.IntelisisFactory.SolicitudMax]
Carpeta=Detalle
Clave=IntelisisFactory.SolicitudMax
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=55x10
[Detalle.IntelisisFactory.ResultadoMax]
Carpeta=Detalle
Clave=IntelisisFactory.ResultadoMax
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


Tamano=55x10









































[Detalle.ListaEnCaptura]
(Inicio)=IntelisisFactory.SolicitudMax
IntelisisFactory.SolicitudMax=IntelisisFactory.ResultadoMax
IntelisisFactory.ResultadoMax=IntelisisFactory.ID
IntelisisFactory.ID=(Fin)

[Detalle.ListaOrden]
(Inicio)=IntelisisFactory.ID	(Decendente)
IntelisisFactory.ID	(Decendente)=IntelisisFactory.EstatusMostrar	(Acendente)
IntelisisFactory.EstatusMostrar	(Acendente)=(Fin)



[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)








[Lista.IntelisisFactory.ID]
Carpeta=Lista
Clave=IntelisisFactory.ID
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


ClaveAccion=IntelisisFactoryD
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
Expresion=Asigna(Info.ID,IntelisisFactory:IntelisisFactory.ID)
Activo=S
Visible=S

[Acciones.Detalle.Forma]
Nombre=Forma
Boton=0
TipoAccion=Formas
ClaveAccion=IntelisisFactoryD
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
ActivoCondicion=Si<BR>  IntelisisFactory:IntelisisFactory.Estatus = <T>ERROR<T><BR>Entonces<BR>  verdadero<BR>Sino<BR>  falso<BR>Fin
[Acciones.Descartar.Actualiza]
Nombre=Actualiza
Boton=0
TipoAccion=Expresion
Expresion=EjecutarSQL( <T>EXEC dbo.spDescartarServicio :tID<T>, IntelisisFactory:IntelisisFactory.ID )
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
(Inicio)=IntelisisFactory.ID
IntelisisFactory.ID=IntelisisFactory.FechaEstatus
IntelisisFactory.FechaEstatus=IntelisisFactory.Sistema
IntelisisFactory.Sistema=IntelisisFactory.Referencia
IntelisisFactory.Referencia=IntelisisFactory.SubReferencia
IntelisisFactory.SubReferencia=(Fin)

[Lista.ListaOrden]
(Inicio)=IntelisisFactory.ID	(Decendente)
IntelisisFactory.ID	(Decendente)=IntelisisFactory.Estatus	(Acendente)
IntelisisFactory.Estatus	(Acendente)=(Fin)










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
