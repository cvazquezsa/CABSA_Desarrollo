[Forma]
Clave=CteArtCompetencia
Nombre=Competencia
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialAlturaCliente=366
PosicionInicialAncho=791
Comentarios=Lista(Info.Cliente, Info.Articulo, Info.SubCuenta)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=244
PosicionInicialArriba=312

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtCteCompetencia
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
OtroOrden=S
ListaOrden=ArtCteCompetencia.Fecha<TAB>(Acendente)
FiltroGeneral=ArtCteCompetencia.Articulo=<T>{Info.Articulo}<T> AND ArtCteCompetencia.SubCuenta=<T>{Info.SubCuenta}<T> AND ArtCteCompetencia.Cliente=<T>{Info.Cliente}<T>

[Lista.ArtCteCompetencia.Fecha]
Carpeta=Lista
Clave=ArtCteCompetencia.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCteCompetencia.Cantidad]
Carpeta=Lista
Clave=ArtCteCompetencia.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCteCompetencia.Precio]
Carpeta=Lista
Clave=ArtCteCompetencia.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCteCompetencia.Competencia]
Carpeta=Lista
Clave=ArtCteCompetencia.Competencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Fecha=99
Cantidad=64
Precio=79
Competencia=246
Comentarios=205
Porcentaje=64

[Lista.ArtCteCompetencia.Comentarios]
Carpeta=Lista
Clave=ArtCteCompetencia.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCteCompetencia.Porcentaje]
Carpeta=Lista
Clave=ArtCteCompetencia.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=ArtCteCompetencia.Fecha
ArtCteCompetencia.Fecha=ArtCteCompetencia.Cantidad
ArtCteCompetencia.Cantidad=ArtCteCompetencia.Precio
ArtCteCompetencia.Precio=ArtCteCompetencia.Porcentaje
ArtCteCompetencia.Porcentaje=ArtCteCompetencia.Competencia
ArtCteCompetencia.Competencia=ArtCteCompetencia.Comentarios
ArtCteCompetencia.Comentarios=(Fin)
