[Forma]
Clave=ProdRutaAlternaLista
Nombre=Rutas Alternas
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
PosicionInicialIzquierda=273
PosicionInicialArriba=206
PosicionInicialAltura=348
PosicionInicialAncho=477
Comentarios=Lista(Info.Ruta, Info.Descripcion)
PosicionInicialAlturaCliente=321

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProdRutaAlterna
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
OtroOrden=S
ListaEnCaptura=(Lista)
ListaOrden=ProdRutaAlterna.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=ProdRutaAlterna.Ruta=<T>{Info.Ruta}<T>

[Lista.ProdRutaAlterna.RutaAlterna]
Carpeta=Lista
Clave=ProdRutaAlterna.RutaAlterna
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdRuta.Descripcion]
Carpeta=Lista
Clave=ProdRuta.Descripcion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.ProdRutaAlterna.Orden]
Carpeta=Lista
Clave=ProdRutaAlterna.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Lista.Columnas]
RutaAlterna=124
Descripcion=286
Orden=36

[Lista.ListaEnCaptura]
(Inicio)=ProdRutaAlterna.RutaAlterna
ProdRutaAlterna.RutaAlterna=ProdRuta.Descripcion
ProdRuta.Descripcion=ProdRutaAlterna.Orden
ProdRutaAlterna.Orden=(Fin)
