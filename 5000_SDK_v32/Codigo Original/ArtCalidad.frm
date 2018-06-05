[Forma]
Clave=ArtCalidad
Nombre=Control de Calidad
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=256
PosicionInicialArriba=257
PosicionInicialAlturaCliente=475
PosicionInicialAncho=767
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Articulo

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtCalidad
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Gris
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
ListaEnCaptura=(Lista)
FiltroGeneral=ArtCalidad.Articulo=<T>{Info.Articulo}<T>

[Lista.ArtCalidad.Evaluacion]
Carpeta=Lista
Clave=ArtCalidad.Evaluacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCalidad.Minimo]
Carpeta=Lista
Clave=ArtCalidad.Minimo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCalidad.Maximo]
Carpeta=Lista
Clave=ArtCalidad.Maximo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Evaluacion=188
Minimo=64
Maximo=67
Unidad=89
Metodo=104
Descripcion=308
Nombre=221

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

[Lista.ArtCalidad.Unidad]
Carpeta=Lista
Clave=ArtCalidad.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCalidad.Metodo]
Carpeta=Lista
Clave=ArtCalidad.Metodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Metodo]
Nombre=Metodo
Boton=90
NombreEnBoton=S
NombreDesplegar=&Métodos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=Metodo
Activo=S
Visible=S

[Lista.Metodo.Nombre]
Carpeta=Lista
Clave=Metodo.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Metodo
Metodo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtCalidad.Evaluacion
ArtCalidad.Evaluacion=ArtCalidad.Minimo
ArtCalidad.Minimo=ArtCalidad.Maximo
ArtCalidad.Maximo=ArtCalidad.Unidad
ArtCalidad.Unidad=ArtCalidad.Metodo
ArtCalidad.Metodo=Metodo.Nombre
Metodo.Nombre=(Fin)
