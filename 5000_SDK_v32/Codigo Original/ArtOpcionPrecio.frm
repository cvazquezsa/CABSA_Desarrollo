[Forma]
Clave=ArtOpcionPrecio
Nombre=Precios Adicionales - Opciones
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=209
PosicionInicialArriba=240
PosicionInicialAltura=288
PosicionInicialAncho=606
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Articulo

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OpcionPrecio
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
ListaOrden=(Lista)
FiltroGeneral=OpcionPrecio.Articulo=<T>{Info.Articulo}<T>

[Lista.OpcionPrecio.Opcion]
Carpeta=Lista
Clave=OpcionPrecio.Opcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Gris

[Lista.OpcionPrecio.Precio]
Carpeta=Lista
Clave=OpcionPrecio.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OpcionPrecio.Moneda]
Carpeta=Lista
Clave=OpcionPrecio.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
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
Opcion=89
Articulo=124
Descripcion1=235
Precio=78
Moneda=74
OpcionDescripcion=239
OpcionDesc=284
Porcentaje=49

[Acciones.OpcionInfo]
Nombre=OpcionInfo
Boton=8
NombreEnBoton=S
NombreDesplegar=&Opciones
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=OpcionInfo
Activo=S
Visible=S

[Lista.OpcionDesc]
Carpeta=Lista
Clave=OpcionDesc
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Gris

[Lista.OpcionPrecio.Porcentaje]
Carpeta=Lista
Clave=OpcionPrecio.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=OpcionInfo
OpcionInfo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=OpcionPrecio.Opcion
OpcionPrecio.Opcion=OpcionDesc
OpcionDesc=OpcionPrecio.Precio
OpcionPrecio.Precio=OpcionPrecio.Moneda
OpcionPrecio.Moneda=OpcionPrecio.Porcentaje
OpcionPrecio.Porcentaje=(Fin)

[Lista.ListaOrden]
(Inicio)=OpcionPrecio.Opcion<TAB>(Acendente)
OpcionPrecio.Opcion<TAB>(Acendente)=OpcionPrecio.Articulo<TAB>(Acendente)
OpcionPrecio.Articulo<TAB>(Acendente)=(Fin)
