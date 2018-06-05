
[Forma]
Clave=ArtUnidadWMS
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Unidades de Artículo
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=273
PosicionInicialArriba=208
PosicionInicialAlturaCliente=273
PosicionInicialAncho=862
ListaAcciones=Cerrar
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaAjustarZonas=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtUnidad
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

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=ArtUnidad.Articulo=<T>{Info.Articulo}<T>
[Lista.ArtUnidad.Unidad]
Carpeta=Lista
Clave=ArtUnidad.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ArtUnidad.Factor]
Carpeta=Lista
Clave=ArtUnidad.Factor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtUnidad.AltoTarima]
Carpeta=Lista
Clave=ArtUnidad.AltoTarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtUnidad.LargoTarima]
Carpeta=Lista
Clave=ArtUnidad.LargoTarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtUnidad.AnchoTarima]
Carpeta=Lista
Clave=ArtUnidad.AnchoTarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtUnidad.Volumen]
Carpeta=Lista
Clave=ArtUnidad.Volumen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtUnidad.Peso]
Carpeta=Lista
Clave=ArtUnidad.Peso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.Columnas]
Unidad=141
AltoTarima=64
LargoTarima=66
AnchoTarima=69
Volumen=79
Peso=64
CantidadUnidadTarima=118
CantidadCamaTarima=101

Factor=64
[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S








[Lista.ArtUnidad.CantidadUnidadTarima]
Carpeta=Lista
Clave=ArtUnidad.CantidadUnidadTarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtUnidad.CantidadCamaTarima]
Carpeta=Lista
Clave=ArtUnidad.CantidadCamaTarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





[Lista.ListaEnCaptura]
(Inicio)=ArtUnidad.Unidad
ArtUnidad.Unidad=ArtUnidad.Factor
ArtUnidad.Factor=ArtUnidad.AltoTarima
ArtUnidad.AltoTarima=ArtUnidad.LargoTarima
ArtUnidad.LargoTarima=ArtUnidad.AnchoTarima
ArtUnidad.AnchoTarima=ArtUnidad.Volumen
ArtUnidad.Volumen=ArtUnidad.Peso
ArtUnidad.Peso=ArtUnidad.CantidadCamaTarima
ArtUnidad.CantidadCamaTarima=ArtUnidad.CantidadUnidadTarima
ArtUnidad.CantidadUnidadTarima=(Fin)
