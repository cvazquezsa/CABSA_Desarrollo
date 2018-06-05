
[Forma]
Clave=WebArtEstatusExistencia
Icono=0
Modulos=(Todos)
Nombre=Estatus Existencia

ListaCarpetas=WebArtEstatusExistencia
CarpetaPrincipal=WebArtEstatusExistencia
PosicionInicialIzquierda=632
PosicionInicialArriba=264
PosicionInicialAlturaCliente=455
PosicionInicialAncho=369
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
BarraHerramientas=S
Comentarios=Lista(<T>Sucursal: <T>+Info.Sucursal, Info.Articulo)
PosicionCol1=248
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
[WebArtEstatusExistencia]
Estilo=Hoja
Clave=WebArtEstatusExistencia
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtEstatusExistencia
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

CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=(Lista)

FiltroGeneral=WebArtEstatusExistencia.SKU = <T>{Temp.Texto}<T> AND WebArtEstatusExistencia.Sucursal = <T>{Info.Sucursal}<T>
[WebArtEstatusExistencia.WebArtEstatusExistencia.ExistenciaMenorOIgual]
Carpeta=WebArtEstatusExistencia
Clave=WebArtEstatusExistencia.ExistenciaMenorOIgual
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[WebArtEstatusExistencia.WebArtEstatusExistencia.WebEstatusExistencia]
Carpeta=WebArtEstatusExistencia
Clave=WebArtEstatusExistencia.WebEstatusExistencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[WebArtEstatusExistencia.Columnas]
Sucursal=64
ExistenciaMenorOIgual=114
WebEstatusExistencia=124







SKU=604


[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
EnBarraHerramientas=S










[Sucursales.Columnas]
0=-2

1=-2
2=113


[Sucursales.WebSucursal.Sucursal]
Carpeta=Sucursales
Clave=WebSucursal.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






[Sucursales.ListaEnCaptura]
(Inicio)=WebSucursal.Sucursal
WebSucursal.Sucursal=WebSucursal.Nombre
WebSucursal.Nombre=(Fin)

[Sucursales.WebSucursal.Nombre]
Carpeta=Sucursales
Clave=WebSucursal.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



[Forma.ListaCarpetas]
(Inicio)=Sucursales
Sucursales=WebArtEstatusExistencia
WebArtEstatusExistencia=(Fin)



[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=WebArtEstatusExistencia
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=WebArtEstatusExistencia.Sucursal
CarpetaVisible=S

[(Carpeta Abrir).WebArtEstatusExistencia.Sucursal]
Carpeta=(Carpeta Abrir)
Clave=WebArtEstatusExistencia.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).Columnas]
0=-2



[WebArtEstatusExistencia.ListaEnCaptura]
(Inicio)=WebArtEstatusExistencia.ExistenciaMenorOIgual
WebArtEstatusExistencia.ExistenciaMenorOIgual=WebArtEstatusExistencia.WebEstatusExistencia
WebArtEstatusExistencia.WebEstatusExistencia=(Fin)

[WebArtEstatusExistencia.ListaOrden]
(Inicio)=WebArtEstatusExistencia.Sucursal	(Acendente)
WebArtEstatusExistencia.Sucursal	(Acendente)=WebArtEstatusExistencia.ExistenciaMenorOIgual	(Acendente)
WebArtEstatusExistencia.ExistenciaMenorOIgual	(Acendente)=(Fin)
