[Forma]
Clave=ArtEstructuraProducto
Nombre=Estructura Producto
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=194
PosicionInicialArriba=189
PosicionInicialAltura=390
PosicionInicialAncho=636
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
EsConsultaExclusiva=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Articulo, Info.Descripcion)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtEstructuraProducto
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
ListaEnCaptura=(Lista)
FiltroArbolClave=ArtEstructuraProducto.Material
FiltroArbolValidar=ArtEstructuraProducto.Material
FiltroArbolRama=ArtEstructuraProducto.Articulo
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Producto
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Arbol
PestanaOtroNombre=S
PestanaNombre=Materiales
FiltroArbolAcumulativas=ArtEstructuraProducto.SeProduce
OtroOrden=S
ListaOrden=(Lista)
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Material<T>
ElementosPorPagina=200
FiltroArbolPosicion=Info.Articulo
IconosNombre=ArtEstructuraProducto:ArtEstructuraProducto.Material

[Lista.Columnas]
0=107
1=179
Descripcion1=604
SubCuenta=124
Cantidad=64
Unidad=304
Merma=64
Desperdicio=71

[Lista.ArtEstructuraProducto.Descripcion1]
Carpeta=Lista
Clave=ArtEstructuraProducto.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtEstructuraProducto.Cantidad]
Carpeta=Lista
Clave=ArtEstructuraProducto.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Mostrar Campos]
Nombre=Mostrar Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Mostrar Campos
Mostrar Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtEstructuraProducto.Descripcion1
ArtEstructuraProducto.Descripcion1=ArtEstructuraProducto.Cantidad
ArtEstructuraProducto.Cantidad=(Fin)

[Lista.ListaOrden]
(Inicio)=ArtEstructuraProducto.Orden<TAB>(Acendente)
ArtEstructuraProducto.Orden<TAB>(Acendente)=ArtEstructuraProducto.Material<TAB>(Acendente)
ArtEstructuraProducto.Material<TAB>(Acendente)=ArtEstructuraProducto.SubCuenta<TAB>(Acendente)
ArtEstructuraProducto.SubCuenta<TAB>(Acendente)=(Fin)
