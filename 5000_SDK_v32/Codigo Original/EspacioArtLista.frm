[Forma]
Clave=EspacioArtLista
Nombre=Artículos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=275
PosicionInicialArriba=163
PosicionInicialAlturaCliente=408
PosicionInicialAncho=474
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
Comentarios=Info.Espacio

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtEspacio
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Art.Descripcion1
CarpetaVisible=S
IconosSubTitulo=<T>Artículo<T>
PestanaOtroNombre=S
PestanaNombre=Artículos
Filtros=S
IconosNombre=ArtEspacio:ArtEspacio.Articulo
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroGeneral=ArtEspacio.Espacio=<T>{Info.Espacio}<T>
FiltroRespetar=S
FiltroTipo=General

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

[Lista.Columnas]
0=130
1=310

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(ArtEspacio:ArtEspacio.Articulo)
Antes=S
AntesExpresiones=Asigna(Info.Articulo, ArtEspacio:ArtEspacio.Articulo)
Visible=S
