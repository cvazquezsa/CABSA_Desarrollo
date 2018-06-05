[Forma]
Clave=SugerirCostoArtCat
Nombre=Costos por Proveedor/Categoría
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=262
PosicionInicialArriba=157
PosicionInicialAltura=454
PosicionInicialAncho=500
ExpresionesAlMostrar=Asigna(Info.ArtCat, Nulo)

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SugerirCostoArtCat
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
PermiteEditar=S
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=(Lista)
FiltroGeneral=SugerirCostoArtCat.Empresa=<T>{Empresa}<T>

[Lista.SugerirCostoArtCat.Categoria]
Carpeta=Lista
Clave=SugerirCostoArtCat.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SugerirCostoArtCat.Proveedor]
Carpeta=Lista
Clave=SugerirCostoArtCat.Proveedor
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
Editar=S

[Lista.Prov.Nombre]
Carpeta=Lista
Clave=Prov.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.SugerirCostoArtCat.Costo]
Carpeta=Lista
Clave=SugerirCostoArtCat.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Categoria=128
Proveedor=80
Nombre=170
Costo=90

[Lista.ListaEnCaptura]
(Inicio)=SugerirCostoArtCat.Categoria
SugerirCostoArtCat.Categoria=SugerirCostoArtCat.Proveedor
SugerirCostoArtCat.Proveedor=Prov.Nombre
Prov.Nombre=SugerirCostoArtCat.Costo
SugerirCostoArtCat.Costo=(Fin)

[Lista.ListaOrden]
(Inicio)=SugerirCostoArtCat.Categoria<TAB>(Acendente)
SugerirCostoArtCat.Categoria<TAB>(Acendente)=SugerirCostoArtCat.Proveedor<TAB>(Acendente)
SugerirCostoArtCat.Proveedor<TAB>(Acendente)=(Fin)
