[Forma]
Clave=ArtAlmABC
Nombre=Conteo Cíclico del Artículo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=316
PosicionInicialArriba=293
PosicionInicialAlturaCliente=404
PosicionInicialAncho=647
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Articulo

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtAlmABC
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
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
HojaPermiteInsertar=S
HojaPermiteEliminar=S
FiltroGeneral=ArtAlmABC.Articulo=<T>{Info.Articulo}<T>

[Lista.Columnas]
Almacen=117
Nombre=278
UltimoConteo=109
SiguienteConteo=111

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S

[Lista.ArtAlmABC.Almacen]
Carpeta=Lista
Clave=ArtAlmABC.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Alm.Nombre]
Carpeta=Lista
Clave=Alm.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.ArtAlmABC.UltimoConteo]
Carpeta=Lista
Clave=ArtAlmABC.UltimoConteo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtAlmABC.SiguienteConteo]
Carpeta=Lista
Clave=ArtAlmABC.SiguienteConteo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ArtAlmABCHist]
Nombre=ArtAlmABCHist
Boton=53
NombreEnBoton=S
NombreDesplegar=&Histórico
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtAlmABCHist
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=ArtAlmABCHist
ArtAlmABCHist=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtAlmABC.Almacen
ArtAlmABC.Almacen=Alm.Nombre
Alm.Nombre=ArtAlmABC.UltimoConteo
ArtAlmABC.UltimoConteo=ArtAlmABC.SiguienteConteo
ArtAlmABC.SiguienteConteo=(Fin)
