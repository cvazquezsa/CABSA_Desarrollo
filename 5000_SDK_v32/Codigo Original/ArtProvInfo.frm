[Forma]
Clave=ArtProvInfo
Nombre=Proveedores del Artículo
Icono=0
Modulos=(Todos)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=206
PosicionInicialArriba=208
PosicionInicialAltura=345
PosicionInicialAncho=611
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Articulo
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=397
ListaCarpetas=Lista

[Lista.ArtProv.Clave]
Carpeta=Lista
Clave=ArtProv.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Proveedor=90
Clave=127
Unidad=97
UltimoCosto=82
UltimaCompra=94
CostoAutorizado=86
0=82
1=72

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

[Lista.ArtProv.UltimoCosto]
Carpeta=Lista
Clave=ArtProv.UltimoCosto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtProv.UltimaCompra]
Carpeta=Lista
Clave=ArtProv.UltimaCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtProv.Unidad]
Carpeta=Lista
Clave=ArtProv.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtProv
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Proveedor<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PestanaOtroNombre=S
IconosNombre=ArtProv:ArtProv.Proveedor
FiltroGeneral=ArtProv.Articulo=<T>{Info.Articulo}<T>

[Lista.ArtProv.SubCuenta]
Carpeta=Lista
Clave=ArtProv.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.ProvInfo]
Nombre=ProvInfo
Boton=34
NombreDesplegar=Información
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ProvInfo
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(ArtProv:ArtProv.Proveedor)
Antes=S
AntesExpresiones=Asigna(Info.Proveedor, ArtProv:ArtProv.Proveedor)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=ProvInfo
ProvInfo=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtProv.SubCuenta
ArtProv.SubCuenta=ArtProv.Clave
ArtProv.Clave=ArtProv.Unidad
ArtProv.Unidad=(Fin)
