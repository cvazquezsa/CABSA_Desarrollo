
[Forma]
Clave=POSArtCBTemp
Icono=0
CarpetaPrincipal=POSArtCBTemp
Modulos=(Todos)
Nombre=Etiquetas Artículos

ListaCarpetas=POSArtCBTemp
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaAcciones=(Lista)
PosicionInicialIzquierda=550
PosicionInicialArriba=274
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[POSArtCBTemp]
Estilo=Hoja
Clave=POSArtCBTemp
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSArtCBTemp
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
FiltroGeneral=POSArtCBTemp.Estacion = {EstacionTrabajo}
FiltroRespetar=S
FiltroTipo=General
[POSArtCBTemp.POSArtCBTemp.Codigo]
Carpeta=POSArtCBTemp
Clave=POSArtCBTemp.Codigo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSArtCBTemp.POSArtCBTemp.Articulo]
Carpeta=POSArtCBTemp
Clave=POSArtCBTemp.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSArtCBTemp.POSArtCBTemp.Cantidad]
Carpeta=POSArtCBTemp
Clave=POSArtCBTemp.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[POSArtCBTemp.Columnas]
Codigo=184
Articulo=124
Cantidad=64

[Acciones.Expresion]
Nombre=Expresion
Boton=4
NombreEnBoton=S
NombreDesplegar=&Imprimir
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S











EspacioPrevio=S











Expresion=ReporteImpresora(<T>POSEtiquetaCB<T>)
[POSArtCBTemp.ListaEnCaptura]
(Inicio)=POSArtCBTemp.Codigo
POSArtCBTemp.Codigo=POSArtCBTemp.Articulo
POSArtCBTemp.Articulo=POSArtCBTemp.Cantidad
POSArtCBTemp.Cantidad=(Fin)
















[Acciones.Preliminar]
Nombre=Preliminar
Boton=68
NombreEnBoton=S
NombreDesplegar=&Preliminar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S









Expresion=ReportePantalla(<T>POSEtiquetaCB<T>)
















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Expresion
Expresion=Preliminar
Preliminar=(Fin)
