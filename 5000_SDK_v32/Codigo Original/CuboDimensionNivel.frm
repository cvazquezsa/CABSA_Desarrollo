[Forma]
Clave=CuboDimensionNivel
Nombre=Niveles de la Dimensión
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=263
PosicionInicialAncho=713
PosicionInicialIzquierda=155
PosicionInicialArriba=235
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Cubo, Info.Dimension, Info.Vista)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CuboDimensionNivel
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=CuboDimensionNivel.Orden<TAB>(Acendente)
FiltroGeneral=CuboDimensionNivel.Cubo=<T>{Info.Cubo}<T> AND<BR>CuboDimensionNivel.Dimension=<T>{Info.Dimension}<T>

[Lista.CuboDimensionNivel.Campo]
Carpeta=Lista
Clave=CuboDimensionNivel.Campo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CuboDimensionNivel.Nombre]
Carpeta=Lista
Clave=CuboDimensionNivel.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CuboDimensionNivel.Descripcion]
Carpeta=Lista
Clave=CuboDimensionNivel.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CuboDimensionNivel.Orden]
Carpeta=Lista
Clave=CuboDimensionNivel.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Campo=199
Nombre=245
Descripcion=201
Orden=36

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

[Lista.ListaEnCaptura]
(Inicio)=CuboDimensionNivel.Campo
CuboDimensionNivel.Campo=CuboDimensionNivel.Nombre
CuboDimensionNivel.Nombre=CuboDimensionNivel.Descripcion
CuboDimensionNivel.Descripcion=CuboDimensionNivel.Orden
CuboDimensionNivel.Orden=(Fin)
