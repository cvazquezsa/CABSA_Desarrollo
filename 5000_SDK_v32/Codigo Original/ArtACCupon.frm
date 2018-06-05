[Forma]
Clave=ArtACCupon
Nombre=Cupones del Artículo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Articulo, Info.Descripcion)
PosicionInicialIzquierda=332
PosicionInicialArriba=310
PosicionInicialAlturaCliente=376
PosicionInicialAncho=616
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtACCupon
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
FiltroGeneral=ArtACCupon.Articulo=<T>{Info.Articulo}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[Lista.ArtACCupon.Cupon]
Carpeta=Lista
Clave=ArtACCupon.Cupon
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtACCupon.Derecho]
Carpeta=Lista
Clave=ArtACCupon.Derecho
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtACCupon.Porcentaje]
Carpeta=Lista
Clave=ArtACCupon.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtACCupon.Importe]
Carpeta=Lista
Clave=ArtACCupon.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtACCupon.PagoDividendos]
Carpeta=Lista
Clave=ArtACCupon.PagoDividendos
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
Cupon=64
Derecho=298
Porcentaje=44
Importe=94
PagoDividendos=83

[Lista.ListaEnCaptura]
(Inicio)=ArtACCupon.Cupon
ArtACCupon.Cupon=ArtACCupon.Derecho
ArtACCupon.Derecho=ArtACCupon.Porcentaje
ArtACCupon.Porcentaje=ArtACCupon.Importe
ArtACCupon.Importe=ArtACCupon.PagoDividendos
ArtACCupon.PagoDividendos=(Fin)
