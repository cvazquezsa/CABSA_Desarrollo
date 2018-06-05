[Forma]
Clave=ArtTemporadaLista
Nombre=Temporadas de Artículos
Icono=0
Modulos=INV
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=Lista
PosicionInicialIzquierda=380
PosicionInicialArriba=208
PosicionInicialAltura=345
PosicionInicialAncho=263
CarpetaPrincipal=Lista
ListaAcciones=Seleccionar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
PosicionInicialAlturaCliente=318

[ArtTemporada.Columnas]
Temporada=104
Descripcion=304

[Lista]
Estilo=Hoja
PestanaNombre=Lista
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtTemporada
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ArtTemporada.Temporada
ListaOrden=ArtTemporada.Temporada<TAB>(Acendente)
CarpetaVisible=S
HojaAjustarColumnas=S
HojaConfirmarEliminar=S
HojaVistaOmision=Automática

[Lista.ArtTemporada.Temporada]
Carpeta=Lista
Clave=ArtTemporada.Temporada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Temporada=234
Descripcion=325

[Detalles.ArtTemporada.Temporada]
Carpeta=Detalles
Clave=ArtTemporada.Temporada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalles.ArtTemporada.Icono]
Carpeta=Detalles
Clave=ArtTemporada.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
EnMenu=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
ConCondicion=S
EjecucionConError=S
Visible=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(ArtTemporada:ArtTemporada.Temporada)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
