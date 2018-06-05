[Forma]
Clave=ArtCostoSucursal
Nombre=Costos Nivel Sucursal
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=124
PosicionInicialArriba=159
PosicionInicialAlturaCliente=415
PosicionInicialAncho=775
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Articulo

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtCosto
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
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=ArtCosto.Empresa=<T>{Empresa}<T> AND ArtCosto.Articulo=<T>{Info.Articulo}<T>
FiltroRespetar=S
FiltroTipo=General

[Lista.ArtCosto.CostoEstandar]
Carpeta=Lista
Clave=ArtCosto.CostoEstandar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCosto.CostoReposicion]
Carpeta=Lista
Clave=ArtCosto.CostoReposicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCosto.UltimoCosto]
Carpeta=Lista
Clave=ArtCosto.UltimoCosto
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Lista.ArtCosto.CostoPromedio]
Carpeta=Lista
Clave=ArtCosto.CostoPromedio
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Lista.ArtCosto.UltimoCostoSinGastos]
Carpeta=Lista
Clave=ArtCosto.UltimoCostoSinGastos
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Lista.Columnas]
CostoEstandar=94
CostoReposicion=94
UltimoCosto=103
CostoPromedio=100
UltimoCostoSinGastos=123
Sucursal=46
Nombre=179

[Lista.ArtCosto.Sucursal]
Carpeta=Lista
Clave=ArtCosto.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Sucursal.Nombre]
Carpeta=Lista
Clave=Sucursal.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

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
(Inicio)=ArtCosto.Sucursal
ArtCosto.Sucursal=Sucursal.Nombre
Sucursal.Nombre=ArtCosto.CostoEstandar
ArtCosto.CostoEstandar=ArtCosto.CostoReposicion
ArtCosto.CostoReposicion=ArtCosto.UltimoCosto
ArtCosto.UltimoCosto=ArtCosto.CostoPromedio
ArtCosto.CostoPromedio=ArtCosto.UltimoCostoSinGastos
ArtCosto.UltimoCostoSinGastos=(Fin)
