
[Forma]
Clave=ActivoFTipoServicioD
Icono=0
Modulos=(Todos)
Nombre=Detalle Servicio

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=273
PosicionInicialAncho=698
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=371
PosicionInicialArriba=300
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Tipo,Info.Servicio)
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoFTipoServicioD
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
PestanaOtroNombre=S
PestanaNombre=Detalle

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=ActivoFTipoServicioD.Tipo = {Comillas(Info.Tipo)} AND ActivoFTipoServicioD.Servicio = {Comillas(Info.Servicio)}
FiltroRespetar=S
FiltroTipo=General
[Lista.ActivoFTipoServicioD.Articulo]
Carpeta=Lista
Clave=ActivoFTipoServicioD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFTipoServicioD.SubCuenta]
Carpeta=Lista
Clave=ActivoFTipoServicioD.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFTipoServicioD.Cantidad]
Carpeta=Lista
Clave=ActivoFTipoServicioD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFTipoServicioD.Unidad]
Carpeta=Lista
Clave=ActivoFTipoServicioD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFTipoServicioD.Almacen]
Carpeta=Lista
Clave=ActivoFTipoServicioD.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Articulo=172
SubCuenta=124
Descripcion1=184
Cantidad=64
Unidad=59
Almacen=64


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
(Inicio)=ActivoFTipoServicioD.Articulo
ActivoFTipoServicioD.Articulo=ActivoFTipoServicioD.SubCuenta
ActivoFTipoServicioD.SubCuenta=Art.Descripcion1
Art.Descripcion1=ActivoFTipoServicioD.Cantidad
ActivoFTipoServicioD.Cantidad=ActivoFTipoServicioD.Unidad
ActivoFTipoServicioD.Unidad=ActivoFTipoServicioD.Almacen
ActivoFTipoServicioD.Almacen=(Fin)
