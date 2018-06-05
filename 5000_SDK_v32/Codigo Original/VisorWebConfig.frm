
[Forma]
Clave=VisorWebConfig
Icono=0
Modulos=(Todos)
Nombre=Configuración Visor Web

ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=362
PosicionInicialArriba=166
PosicionInicialAlturaCliente=488
PosicionInicialAncho=715




PosicionSec1=104

PosicionCol1=260
ListaAcciones=(Lista)
[Detalle.VisorWebConfigD.TabTitulo]
Carpeta=Detalle
Clave=VisorWebConfigD.TabTitulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Detalle.VisorWebConfigD.Zona]
Carpeta=Detalle
Clave=VisorWebConfigD.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Detalle.VisorWebConfigD.ZonaTitulo]
Carpeta=Detalle
Clave=VisorWebConfigD.ZonaTitulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Detalle.VisorWebConfigD.URL]
Carpeta=Detalle
Clave=VisorWebConfigD.URL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Detalle.VisorWebConfigD.Bloqueado]
Carpeta=Detalle
Clave=VisorWebConfigD.Bloqueado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Hoja]
Estilo=Hoja
Clave=Hoja
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VisorWebConfig
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
ListaEnCaptura=VisorWebConfig.Formato

CarpetaVisible=S
[Hoja.ListaEnCaptura]
(Inicio)=VisorWebConfig.Formato
VisorWebConfig.Formato=VisorWebConfig.Descripcion
VisorWebConfig.Descripcion=VisorWebConfig.Editable
VisorWebConfig.Editable=(Fin)

[Hoja.VisorWebConfig.Formato]
Carpeta=Hoja
Clave=VisorWebConfig.Formato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



[Hoja.Columnas]
Formato=228
Descripcion=536
Editable=64

[Detalle.Columnas]
Orden=20
TabTitulo=272
Zona=40
ZonaTitulo=126
URL=369
Bloqueado=64







[Detalle.ListaEnCaptura]
(Inicio)=VisorWebConfigD.Orden
VisorWebConfigD.Orden=VisorWebConfigD.TabTitulo
VisorWebConfigD.TabTitulo=VisorWebConfigD.Zona
VisorWebConfigD.Zona=VisorWebConfigD.ZonaTitulo
VisorWebConfigD.ZonaTitulo=VisorWebConfigD.URL
VisorWebConfigD.URL=VisorWebConfigD.Bloqueado
VisorWebConfigD.Bloqueado=(Fin)

[Detalle.VisorWebConfigD.Orden]
Carpeta=Detalle
Clave=VisorWebConfigD.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=VisorWebConfig
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Ficha.VisorWebConfig.Formato]
Carpeta=Ficha
Clave=VisorWebConfig.Formato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ficha.VisorWebConfig.Descripcion]
Carpeta=Ficha
Clave=VisorWebConfig.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ficha.VisorWebConfig.Editable]
Carpeta=Ficha
Clave=VisorWebConfig.Editable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco







[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalle
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=VisorWebConfigD
Activo=S
Visible=S





Antes=S





































EspacioPrevio=S
AntesExpresiones=Asigna(Info.Categoria,VisorWebConfig:VisorWebConfig.Formato)
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
EnBarraHerramientas=S
Activo=S
Visible=S



NombreDesplegar=&Nuevo
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar






[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S



































































[Acciones.Usuarios]
Nombre=Usuarios
Boton=60
NombreEnBoton=S
NombreDesplegar=&Usuarios
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=VisorWebConfigUsuario
Activo=S
Visible=S













Antes=S
























EspacioPrevio=S
AntesExpresiones=Asigna(Info.Categoria,VisorWebConfig:VisorWebConfig.Formato)
[Ficha.ListaEnCaptura]
(Inicio)=VisorWebConfig.Formato
VisorWebConfig.Formato=VisorWebConfig.Descripcion
VisorWebConfig.Descripcion=VisorWebConfig.Editable
VisorWebConfig.Editable=(Fin)

























































[Forma.ListaCarpetas]
(Inicio)=Hoja
Hoja=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Detalle
Detalle=Usuarios
Usuarios=(Fin)
