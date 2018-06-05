[Forma]
Clave=ArtPresenta
Nombre=Otras presentaciones del Artículo
Icono=0
Modulos=(Todos)
ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
PosicionInicialIzquierda=318
PosicionInicialArriba=384
PosicionInicialAltura=255
PosicionInicialAncho=644
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Articulo, Info.Descripcion)
VentanaExclusiva=S
PosicionInicialAlturaCliente=228

[Hoja]
Estilo=Hoja
Clave=Hoja
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtPresenta
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaAjustarColumnas=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroGeneral=ArtPresenta.Articulo=<T>{Info.Articulo}<T>
FiltroRespetar=S
FiltroAncho=30
FiltroPredefinido=S

[Hoja.ArtPresenta.Presentacion]
Carpeta=Hoja
Clave=ArtPresenta.Presentacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Hoja.ArtPresenta.Factor]
Carpeta=Hoja
Clave=ArtPresenta.Factor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Hoja.Columnas]
Presentacion=130
Factor=86
Descripcion=195
Descripcion1=202

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

[Hoja.ArtPresenta.Descripcion]
Carpeta=Hoja
Clave=ArtPresenta.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Hoja.Art.Descripcion1]
Carpeta=Hoja
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=33

[Hoja.ListaEnCaptura]
(Inicio)=ArtPresenta.Presentacion
ArtPresenta.Presentacion=Art.Descripcion1
Art.Descripcion1=ArtPresenta.Descripcion
ArtPresenta.Descripcion=ArtPresenta.Factor
ArtPresenta.Factor=(Fin)
