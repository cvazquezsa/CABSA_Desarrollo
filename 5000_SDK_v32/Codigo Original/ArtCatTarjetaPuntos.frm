[Forma]
Clave=ArtCatTarjetaPuntos
Nombre=Puntos Monedero por Categoría
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=664
PosicionInicialArriba=362
PosicionInicialAlturaCliente=449
PosicionInicialAncho=592
ListaAcciones=Guardar

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtCatTarjetaPuntos
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

[Lista.ArtCatTarjetaPuntos.Categoria]
Carpeta=Lista
Clave=ArtCatTarjetaPuntos.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCatTarjetaPuntos.Porcentaje]
Carpeta=Lista
Clave=ArtCatTarjetaPuntos.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCatTarjetaPuntos.FechaD]
Carpeta=Lista
Clave=ArtCatTarjetaPuntos.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCatTarjetaPuntos.FechaA]
Carpeta=Lista
Clave=ArtCatTarjetaPuntos.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Categoria=304
Porcentaje=64
FechaD=94
FechaA=94

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=ArtCatTarjetaPuntos.Categoria
ArtCatTarjetaPuntos.Categoria=ArtCatTarjetaPuntos.Porcentaje
ArtCatTarjetaPuntos.Porcentaje=ArtCatTarjetaPuntos.FechaD
ArtCatTarjetaPuntos.FechaD=ArtCatTarjetaPuntos.FechaA
ArtCatTarjetaPuntos.FechaA=(Fin)
