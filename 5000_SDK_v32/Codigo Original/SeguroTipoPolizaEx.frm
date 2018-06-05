[Forma]
Clave=SeguroTipoPolizaEx
Nombre=Excepciones
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Tipo
PosicionInicialIzquierda=360
PosicionInicialArriba=315
PosicionInicialAlturaCliente=360
PosicionInicialAncho=433
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
Vista=SeguroTipoPolizaEx
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
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=SeguroTipoPolizaEx.Tipo=<T>{Info.Tipo}<T>

[Lista.SeguroTipoPolizaEx.Articulo]
Carpeta=Lista
Clave=SeguroTipoPolizaEx.Articulo
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
Articulo=124
CantidadMaxima=86
PrecioMaximo=145
Descripcion1=277
ImporteMaximo=127

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.ListaEnCaptura]
(Inicio)=SeguroTipoPolizaEx.Articulo
SeguroTipoPolizaEx.Articulo=Art.Descripcion1
Art.Descripcion1=(Fin)
