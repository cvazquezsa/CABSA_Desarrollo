

[Forma]
Clave=VisorEventosISD
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
Vista=VisorEventosIS
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
FiltroGeneral=VisorEventosIS.ID=<T>{Info.ID}<T>
[Detalle.VisorEventosIS.ID]
Carpeta=Detalle
Clave=VisorEventosIS.ID
Editar=N
LineaNueva=N
ValidaNombre=S
3D=N
ColorFondo=$00F0F0F0

Tamano=10
[Detalle.VisorEventosIS.Sistema]
Carpeta=Detalle
Clave=VisorEventosIS.Sistema
Editar=N
LineaNueva=S
ValidaNombre=S
3D=N
Tamano=10
ColorFondo=$00F0F0F0

[Detalle.VisorEventosIS.Referencia]
Carpeta=Detalle
Clave=VisorEventosIS.Referencia
Editar=N
LineaNueva=N
ValidaNombre=S
3D=N
Tamano=25
ColorFondo=$00F0F0F0

[Detalle.VisorEventosIS.SubReferencia]
Carpeta=Detalle
Clave=VisorEventosIS.SubReferencia
Editar=N
LineaNueva=N
ValidaNombre=S
3D=N
Tamano=20
ColorFondo=$00F0F0F0


[Detalle.VisorEventosIS.FechaEstatus]
Carpeta=Detalle
Clave=VisorEventosIS.FechaEstatus
Editar=N
LineaNueva=N
ValidaNombre=S
3D=N
Tamano=20
ColorFondo=$00F0F0F0





[Detalle.VisorEventosIS.EstatusMostrar]
Carpeta=Detalle
Clave=VisorEventosIS.EstatusMostrar
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
Vista=VisorEventosIS
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
(Inicio)=VisorEventosIS.Referencia
VisorEventosIS.Referencia=VisorEventosIS.SubReferencia
VisorEventosIS.SubReferencia=VisorEventosIS.Estatus
VisorEventosIS.Estatus=(Fin)




[(Carpeta Abrir).Columnas]
0=-2
1=-2
2=-2

































[Detalle.VisorEventosIS.Ok]
Carpeta=Detalle
Clave=VisorEventosIS.Ok
Editar=N
LineaNueva=S
ValidaNombre=S
3D=N
Tamano=10
ColorFondo=$00F0F0F0

[Detalle.VisorEventosIS.OkRef]
Carpeta=Detalle
Clave=VisorEventosIS.OkRef
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
Vista=VisorEventosIS
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

[Solicitud.VisorEventosIS.ResultadoMax]
Carpeta=Solicitud
Clave=VisorEventosIS.ResultadoMax
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
ClaveAccion=VisorEventosIS
Activo=S
Visible=S

























[Detalle.ListaEnCaptura]
(Inicio)=VisorEventosIS.ID
VisorEventosIS.ID=VisorEventosIS.EstatusMostrar
VisorEventosIS.EstatusMostrar=VisorEventosIS.FechaEstatus
VisorEventosIS.FechaEstatus=VisorEventosIS.Sistema
VisorEventosIS.Sistema=VisorEventosIS.Referencia
VisorEventosIS.Referencia=VisorEventosIS.SubReferencia
VisorEventosIS.SubReferencia=VisorEventosIS.Ok
VisorEventosIS.Ok=VisorEventosIS.OkRef
VisorEventosIS.OkRef=(Fin)




















[Solicitud.VisorEventosIS.SolicitudMax]
Carpeta=Solicitud
Clave=VisorEventosIS.SolicitudMax
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=46x18


[Solicitud.ListaEnCaptura]
(Inicio)=VisorEventosIS.SolicitudMax
VisorEventosIS.SolicitudMax=VisorEventosIS.ResultadoMax
VisorEventosIS.ResultadoMax=(Fin)



[Forma.ListaCarpetas]
(Inicio)=Detalle
Detalle=Solicitud
Solicitud=(Fin)

[Forma.ListaAcciones]
(Inicio)=Abrir
Abrir=Cerrar
Cerrar=Excel
Excel=(Fin)
