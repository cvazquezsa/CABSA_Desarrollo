
[Forma]
Clave=IntelisisFactoryD
Icono=0
Nombre=Detalle de la Solicitud
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=333
PosicionInicialArriba=115
PosicionInicialAlturaCliente=460
PosicionInicialAncho=700
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSec1=101
Menus=S
MenuPrincipal=&Archivo
[Detalle]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Detalle de la Solicitud
Clave=Detalle
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=IntelisisFactory
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=$00F0F0F0
ListaEnCaptura=(Lista)

CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=IntelisisFactory.ID=<T>{Info.ID}<T>
[Detalle.IntelisisFactory.ID]
Carpeta=Detalle
Clave=IntelisisFactory.ID
Editar=N
LineaNueva=N
ValidaNombre=S
3D=N
ColorFondo=$00F0F0F0

Tamano=10
[Detalle.IntelisisFactory.Sistema]
Carpeta=Detalle
Clave=IntelisisFactory.Sistema
Editar=N
LineaNueva=S
ValidaNombre=S
3D=N
Tamano=10
ColorFondo=$00F0F0F0

[Detalle.IntelisisFactory.Referencia]
Carpeta=Detalle
Clave=IntelisisFactory.Referencia
Editar=N
LineaNueva=N
ValidaNombre=S
3D=N
Tamano=25
ColorFondo=$00F0F0F0

[Detalle.IntelisisFactory.SubReferencia]
Carpeta=Detalle
Clave=IntelisisFactory.SubReferencia
Editar=N
LineaNueva=N
ValidaNombre=S
3D=N
Tamano=20
ColorFondo=$00F0F0F0


[Detalle.IntelisisFactory.FechaEstatus]
Carpeta=Detalle
Clave=IntelisisFactory.FechaEstatus
Editar=N
LineaNueva=N
ValidaNombre=S
3D=N
Tamano=20
ColorFondo=$00F0F0F0





[Detalle.IntelisisFactory.EstatusMostrar]
Carpeta=Detalle
Clave=IntelisisFactory.EstatusMostrar
Editar=N
LineaNueva=N
ValidaNombre=S
3D=N
Tamano=25
ColorFondo=$00F0F0F0


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






[(Carpeta Abrir)]
Estilo=Iconos
Pestana=S
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=IntelisisFactory
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco

CarpetaVisible=S
[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=IntelisisFactory.Referencia
IntelisisFactory.Referencia=IntelisisFactory.SubReferencia
IntelisisFactory.SubReferencia=IntelisisFactory.Estatus
IntelisisFactory.Estatus=(Fin)




[(Carpeta Abrir).Columnas]
0=-2
1=-2
2=-2

































[Detalle.IntelisisFactory.Ok]
Carpeta=Detalle
Clave=IntelisisFactory.Ok
Editar=N
LineaNueva=S
ValidaNombre=S
3D=N
Tamano=10
ColorFondo=$00F0F0F0

[Detalle.IntelisisFactory.OkRef]
Carpeta=Detalle
Clave=IntelisisFactory.OkRef
Editar=N
LineaNueva=N
ValidaNombre=S
3D=N
Tamano=25
ColorFondo=$00F0F0F0



[Solicitud]
Estilo=Ficha
Clave=Solicitud
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=IntelisisFactory
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=139
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=$00F0F0F0
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

PermiteEditar=S

[Solicitud.IntelisisFactory.ResultadoMax]
Carpeta=Solicitud
Clave=IntelisisFactory.ResultadoMax
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=46x18
ColorFondo=Blanco


































[Acciones.Abrir]
Nombre=Abrir
Boton=2
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
NombreDesplegar=&Abrir...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=IntelisisFactory
Activo=S
Visible=S

























[Detalle.ListaEnCaptura]
(Inicio)=IntelisisFactory.ID
IntelisisFactory.ID=IntelisisFactory.EstatusMostrar
IntelisisFactory.EstatusMostrar=IntelisisFactory.FechaEstatus
IntelisisFactory.FechaEstatus=IntelisisFactory.Sistema
IntelisisFactory.Sistema=IntelisisFactory.Referencia
IntelisisFactory.Referencia=IntelisisFactory.SubReferencia
IntelisisFactory.SubReferencia=IntelisisFactory.Ok
IntelisisFactory.Ok=IntelisisFactory.OkRef
IntelisisFactory.OkRef=(Fin)




















[Solicitud.IntelisisFactory.SolicitudMax]
Carpeta=Solicitud
Clave=IntelisisFactory.SolicitudMax
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=46x18


[Solicitud.ListaEnCaptura]
(Inicio)=IntelisisFactory.SolicitudMax
IntelisisFactory.SolicitudMax=IntelisisFactory.ResultadoMax
IntelisisFactory.ResultadoMax=(Fin)



[Forma.ListaCarpetas]
(Inicio)=Detalle
Detalle=Solicitud
Solicitud=(Fin)

[Forma.ListaAcciones]
(Inicio)=Abrir
Abrir=Cerrar
Cerrar=Excel
Excel=(Fin)
