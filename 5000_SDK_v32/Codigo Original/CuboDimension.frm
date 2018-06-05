[Forma]
Clave=CuboDimension
Nombre=Dimensiones del Cubo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=229
PosicionInicialArriba=184
PosicionInicialAlturaCliente=365
PosicionInicialAncho=626
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Cubo

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CuboDimension
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
FiltroGeneral=CuboDimension.Cubo=<T>{Info.Cubo}<T>

[Lista.CuboDimension.Descripcion]
Carpeta=Lista
Clave=CuboDimension.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Nombre=242
Descripcion=217
Dimension=204
Tipo=135
Activa=38

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

[Lista.CuboDimension.Dimension]
Carpeta=Lista
Clave=CuboDimension.Dimension
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.CuboDimensionNivel]
Nombre=CuboDimensionNivel
Boton=47
NombreEnBoton=S
NombreDesplegar=&Niveles
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CuboDimensionNivel
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(CuboDimension:CuboDimension.Dimension)
Antes=S
AntesExpresiones=Asigna(Info.Dimension, CuboDimension:CuboDimension.Dimension)
DespuesGuardar=S
Visible=S

[Lista.CuboDimension.Tipo]
Carpeta=Lista
Clave=CuboDimension.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CuboDimension.Activa]
Carpeta=Lista
Clave=CuboDimension.Activa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CuboDimensionNivel
CuboDimensionNivel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CuboDimension.Dimension
CuboDimension.Dimension=CuboDimension.Tipo
CuboDimension.Tipo=CuboDimension.Activa
CuboDimension.Activa=CuboDimension.Descripcion
CuboDimension.Descripcion=(Fin)
