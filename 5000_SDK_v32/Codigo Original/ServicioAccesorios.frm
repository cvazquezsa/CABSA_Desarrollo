[Forma]
Clave=ServicioAccesorios
Nombre=<T>Accesorios - <T>+Info.Mov+<T> <T>+Info.MovID
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=219
PosicionInicialArriba=152
PosicionInicialAltura=463
PosicionInicialAncho=586
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Di�logo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ServicioAccesorios
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
ValidarCampos=S
ListaCamposAValidar=Art.Descripcion1
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroGeneral=ServicioAccesorios.ID={Info.ID}
FiltroRespetar=S
FiltroTipo=General

[Lista.ServicioAccesorios.Articulo]
Carpeta=Lista
Clave=ServicioAccesorios.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ServicioAccesorios.Serie]
Carpeta=Lista
Clave=ServicioAccesorios.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Articulo=165
Descripcion1=244
Serie=162
Observaciones=229

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

[Lista.ServicioAccesorios.Observaciones]
Carpeta=Lista
Clave=ServicioAccesorios.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
IgnoraFlujo=S

[Acciones.ArtExpress]
Nombre=ArtExpress
Boton=14
NombreDesplegar=&Agregar Art�culo
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtExpress
Visible=S
NombreEnBoton=S
EspacioPrevio=S
ActivoCondicion=Usuario.AgregarArtExpress

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=ArtExpress
ArtExpress=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ServicioAccesorios.Articulo
ServicioAccesorios.Articulo=ServicioAccesorios.Serie
ServicioAccesorios.Serie=ServicioAccesorios.Observaciones
ServicioAccesorios.Observaciones=(Fin)
