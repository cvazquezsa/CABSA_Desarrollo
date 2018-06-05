[Forma]
Clave=ArtMatriz
Nombre=<T>Matriz - <T>+Info.Descripcion
Icono=0
Modulos=INV
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=367
PosicionInicialArriba=210
PosicionInicialAltura=340
PosicionInicialAncho=289
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Guardar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
VentanaEscCerrar=
Comentarios=Info.Articulo
VentanaExclusiva=S
PosicionInicialAlturaCliente=313

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtMatriz
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
PermiteEditar=S
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(Sin clasificar)
FiltroRespetar=S
FiltroAncho=30
HojaMantenerSeleccion=S
FiltroGeneral=ArtMatriz.Articulo=<T>{Info.Articulo}<T>

[Lista.Columnas]
Color=136
Talla=109
Renglon=140
Columna=120

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S
Activo=S

[Lista.ArtMatriz.Renglon]
Carpeta=Lista
Clave=ArtMatriz.Renglon
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtMatriz.Columna]
Carpeta=Lista
Clave=ArtMatriz.Columna
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=ArtMatriz.Renglon
ArtMatriz.Renglon=ArtMatriz.Columna
ArtMatriz.Columna=(Fin)
