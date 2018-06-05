
[Forma]
Clave=WebCBLista
Nombre=Codigos Artículos
Icono=0
Modulos=INV
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=Lista
PosicionInicialIzquierda=454
PosicionInicialArriba=252
PosicionInicialAltura=345
PosicionInicialAncho=692
CarpetaPrincipal=Lista
ListaAcciones=Seleccionar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
PosicionInicialAlturaCliente=318

[ArtCat.Columnas]
Categoria=104
Descripcion=304

[Lista]
Estilo=Hoja
PestanaNombre=Lista
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=eCommerceCB
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaOrden=eCommerceCB.Codigo<TAB>(Acendente)
CarpetaVisible=S
HojaAjustarColumnas=S
HojaConfirmarEliminar=S
HojaVistaOmision=Automática


ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaMostrarColumnas=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroGeneral=eCommerceCB.TipoCuenta = <T>Articulos<T>
[Lista.Columnas]
Categoria=234
Descripcion=325

Nombre=307
Codigo=149
Cuenta=225
Unidad=86
Cantidad=64
SubCuenta=124
SerieLote=124
Descripcion1=184
[Detalles.ArtCat.Categoria]
Carpeta=Detalles
Clave=ArtCat.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalles.ArtCat.Icono]
Carpeta=Detalles
Clave=ArtCat.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
EnMenu=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S



Antes=S
GuardarAntes=S
DespuesGuardar=S






AntesExpresiones=Asigna(Info.Cantidad,eCommerceCB:eCommerceCB.Cantidad)<BR>Asigna(Info.Unidad,eCommerceCB:eCommerceCB.Unidad)<BR>Asigna(Info.SerieLote,eCommerceCB:eCommerceCB.SerieLote)<BR>Asigna(Info.SubCuenta,eCommerceCB:eCommerceCB.SubCuenta)<BR>Asigna(Info.ArtModelo,eCommerceCB:eCommerceCB.Cuenta)<BR>Asigna(Info.Copiar,Verdadero)
[Lista.eCommerceCB.Codigo]
Carpeta=Lista
Clave=eCommerceCB.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.eCommerceCB.Cuenta]
Carpeta=Lista
Clave=eCommerceCB.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.eCommerceCB.Unidad]
Carpeta=Lista
Clave=eCommerceCB.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.eCommerceCB.Cantidad]
Carpeta=Lista
Clave=eCommerceCB.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.eCommerceCB.SubCuenta]
Carpeta=Lista
Clave=eCommerceCB.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



[Lista.ListaEnCaptura]
(Inicio)=eCommerceCB.Codigo
eCommerceCB.Codigo=eCommerceCB.Cuenta
eCommerceCB.Cuenta=Art.Descripcion1
Art.Descripcion1=eCommerceCB.Unidad
eCommerceCB.Unidad=eCommerceCB.Cantidad
eCommerceCB.Cantidad=eCommerceCB.SubCuenta
eCommerceCB.SubCuenta=(Fin)
