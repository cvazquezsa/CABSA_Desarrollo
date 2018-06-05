[Forma]
Clave=PresentacionPrecio
Nombre=Precios de la Presentación
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=205
PosicionInicialArriba=263
PosicionInicialAlturaCliente=464
PosicionInicialAncho=869
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Info.Presentacion
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=Asigna(Def.Region, Nulo)<BR>Asigna(Def.Sucursal, Nulo)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PresentacionPrecio
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
FiltroAncho=15
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroGrupo1=PresentacionPrecio.Region
FiltroValida1=PresentacionPrecio.Region
FiltroGrupo2=PresentacionPrecio.Sucursal
FiltroValida2=Sucursal.Nombre
FiltroTodo=S
FiltroGeneral=PresentacionPrecio.Presentacion=<T>{Info.Presentacion}<T>

[Lista.PresentacionPrecio.Region]
Carpeta=Lista
Clave=PresentacionPrecio.Region
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PresentacionPrecio.Sucursal]
Carpeta=Lista
Clave=PresentacionPrecio.Sucursal
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

[Lista.PresentacionPrecio.CantidadD]
Carpeta=Lista
Clave=PresentacionPrecio.CantidadD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PresentacionPrecio.CantidadA]
Carpeta=Lista
Clave=PresentacionPrecio.CantidadA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PresentacionPrecio.PrecioNormal]
Carpeta=Lista
Clave=PresentacionPrecio.PrecioNormal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PresentacionPrecio.PrecioOferta]
Carpeta=Lista
Clave=PresentacionPrecio.PrecioOferta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PresentacionPrecio.VigenciaD]
Carpeta=Lista
Clave=PresentacionPrecio.VigenciaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PresentacionPrecio.VigenciaA]
Carpeta=Lista
Clave=PresentacionPrecio.VigenciaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Region=104
Sucursal=95
Nombre=106
CantidadD=34
CantidadA=38
PrecioNormal=90
PrecioOferta=87
VigenciaD=82
VigenciaA=84

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
(Inicio)=PresentacionPrecio.Region
PresentacionPrecio.Region=PresentacionPrecio.Sucursal
PresentacionPrecio.Sucursal=Sucursal.Nombre
Sucursal.Nombre=PresentacionPrecio.CantidadD
PresentacionPrecio.CantidadD=PresentacionPrecio.CantidadA
PresentacionPrecio.CantidadA=PresentacionPrecio.PrecioNormal
PresentacionPrecio.PrecioNormal=PresentacionPrecio.PrecioOferta
PresentacionPrecio.PrecioOferta=PresentacionPrecio.VigenciaD
PresentacionPrecio.VigenciaD=PresentacionPrecio.VigenciaA
PresentacionPrecio.VigenciaA=(Fin)
