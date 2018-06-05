[Forma]
Clave=ArtAlmABCHist
Nombre=Histórico
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
Comentarios=Lista(Info.Articulo, Info.Almacen)
PosicionInicialIzquierda=228
PosicionInicialArriba=190
PosicionInicialAlturaCliente=353
PosicionInicialAncho=568
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtAlmABCHist
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Fecha<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PestanaOtroNombre=S
IconosNombre=ArtAlmABCHist:ArtAlmABCHist.Fecha
FiltroGeneral=ArtAlmABCHist.Articulo=<T>{Info.Articulo}<T> AND<BR>ArtAlmABCHist.Almacen=<T>{Info.Almacen}<T>

[Lista.ArtAlmABCHist.UltimoConteo]
Carpeta=Lista
Clave=ArtAlmABCHist.UltimoConteo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtAlmABCHist.SiguienteConteo]
Carpeta=Lista
Clave=ArtAlmABCHist.SiguienteConteo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
0=135
1=138

[Lista.ListaEnCaptura]
(Inicio)=ArtAlmABCHist.UltimoConteo
ArtAlmABCHist.UltimoConteo=ArtAlmABCHist.SiguienteConteo
ArtAlmABCHist.SiguienteConteo=(Fin)
