[Forma]
Clave=ArtConsignacion
Nombre=<T>Existencias a Consignación<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=Lista
ListaAcciones=Cerrar
PosicionInicialIzquierda=388
PosicionInicialArriba=255
PosicionInicialAltura=258
PosicionInicialAncho=248
Comentarios=e(<T>Artículo<T>)+<T>: <T>+Info.Articulo
VentanaEscCerrar=S
EsConsultaExclusiva=S

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
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

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtConsignacion
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Almacén<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ArtConsignacion.Consignacion
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
FiltroPredefinido=S
CarpetaVisible=S
PestanaOtroNombre=S
IconosNombre=ArtConsignacion:ArtConsignacion.Almacen
FiltroGeneral=Empresa=<T>{Empresa}<T> AND Articulo=<T>{Info.Articulo}<T>

[Lista.ArtConsignacion.Consignacion]
Carpeta=Lista
Clave=ArtConsignacion.Consignacion
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=80
1=103
